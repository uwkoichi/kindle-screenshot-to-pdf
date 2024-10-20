#!/bin/bash

BOOK_NAME=$1
repeat_count=$(($2 / 2))
SAVE_DIR="$HOME/book_screenshots/$BOOK_NAME"

if [ ! -d "$SAVE_DIR" ];then
  mkdir -p "$SAVE_DIR"
  echo "ディレクトリを作成しました: $SAVE_DIR"
fi

osascript -e 'tell application "Amazon Kindle.app" to activate'
sleep 1

image_list=""

echo "スクリーンショットを開始します"
for i in $(seq 1 $repeat_count)
do
  FILENAME="screenshot_$(date +%Y%m%d_%H%M%S)_${i}.png"
  SAVE_PATH="$SAVE_DIR/$FILENAME"

  screencapture -x "$SAVE_PATH"

  image_list="$image_list $SAVE_PATH"

  osascript -e 'tell application "System Events" to key code 124' # 左カーソル: 123, 右カーソル: 124

  sleep 0.3
done
echo "スクリーンショットを開始します"

echo "PDFファイルを作成・圧縮を開始します"
PDF_FILE="$SAVE_DIR/$BOOK_NAME.pdf"
magick $image_list -resize 70% -quality 90 $PDF_FILE # 画像のリサイズと圧縮率は適宜調整してください

rm $image_list

echo "完了しました"
