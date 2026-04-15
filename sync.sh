#!/bin/bash
# 《废土残王》GitHub同步脚本
# 用法: bash sync.sh [commit消息]

REPO_DIR="/home/zy/fanqie-novel"
REMOTE_URL="https://github.com/yolefish/fanqie-novel.git"

cd "$REPO_DIR" || exit 1

# 添加所有更改
git add -A

# 检查是否有更改
if git diff --cached --quiet; then
    echo "✅ 没有新更改需要提交"
    exit 0
fi

# 获取commit消息
if [ -z "$1" ]; then
    COMMIT_MSG="update: $(date '+%Y-%m-%d %H:%M') 自动同步"
else
    COMMIT_MSG="$1"
fi

# 提交
git commit -m "$COMMIT_MSG"

# 推送
echo "📤 正在推送 到 GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo "✅ 同步成功!"
else
    echo "❌ 同步失败，请检查网络和仓库设置"
fi
