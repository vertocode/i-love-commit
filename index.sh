#!/usr/bin/env sh

_() {
  USERNAME=""
  ACCESS_TOKEN=""

  echo "GitHub Username: "
  read -r USERNAME

  [ -z "$USERNAME" ] && exit 1

  git init
  for YEAR in $(seq 2001 2023); do
    for MONTH in {01..12}; do
      for DAY in {01..25}; do
        echo "**$MONTH** - Generated by https://github.com/${USERNAME}/i-love-commit" \
            >README.md
        DATE="${YEAR}-${MONTH}-${DAY}T12:00:00"
        GIT_AUTHOR_DATE="$DATE" \
          GIT_COMMITTER_DATE="$DATE" \
          echo "**${DATE}** - Commit message for ${DATE}" \
          >README.md
        git add .
            GIT_AUTHOR_DATE="${YEAR}-${MONTH}-${DAY}T18:00:00" \
              GIT_COMMITTER_DATE="${YEAR}-${MONTH}-${DAY}T18:00:00" \
              git commit -m "${YEAR}"
        git commit -m "Commit on ${DATE}"
      done
    done
  done

  echo "GitHub Access token(optional to push): "
  read -r ACCESS_TOKEN

  [ -z "$ACCESS_TOKEN" ] && echo 'All commits was done, you need to push now!' && exit 1

  git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/i-love-commit.git"
  git branch -M main
  git push -u origin main -f

  echo "Cool, check your profile now: https://github.com/${USERNAME}"
} && _

unset -f _
