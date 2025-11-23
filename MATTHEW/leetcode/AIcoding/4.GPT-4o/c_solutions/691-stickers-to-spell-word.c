#include <stdio.h>
#include <string.h>
#include <limits.h>

#define MAX_N 50
#define MAX_M 10
#define MAX_L 10

int dp[1 << MAX_L];

int minStickers(char **stickers, int stickersSize, char *target) {
    int targetCount[26] = {0};
    for (int i = 0; target[i]; i++) {
        targetCount[target[i] - 'a']++;
    }

    int stickerCount[MAX_N][26] = {0};
    for (int i = 0; i < stickersSize; i++) {
        for (int j = 0; stickers[i][j]; j++) {
            stickerCount[i][stickers[i][j] - 'a']++;
        }
    }

    memset(dp, -1, sizeof(dp));
    dp[0] = 0;

    for (int mask = 0; mask < (1 << strlen(target)); mask++) {
        if (dp[mask] == -1) continue;
        for (int i = 0; i < stickersSize; i++) {
            int newMask = mask;
            int tempCount[26] = {0};
            for (int j = 0; j < 26; j++) {
                tempCount[j] = stickerCount[i][j];
            }

            for (int j = 0; j < strlen(target); j++) {
                if (((mask >> j) & 1) == 0 && targetCount[target[j] - 'a'] > 0) {
                    while (tempCount[target[j] - 'a'] > 0) {
                        tempCount[target[j] - 'a']--;
                        newMask |= (1 << j);
                        targetCount[target[j] - 'a']--;
                        if ((newMask >> j) & 1) break;
                    }
                }
            }

            dp[newMask] = dp[newMask] == -1 ? dp[mask] + 1 : fmin(dp[newMask], dp[mask] + 1);
        }
    }

    return dp[(1 << strlen(target)) - 1] == -1 ? -1 : dp[(1 << strlen(target)) - 1];
}