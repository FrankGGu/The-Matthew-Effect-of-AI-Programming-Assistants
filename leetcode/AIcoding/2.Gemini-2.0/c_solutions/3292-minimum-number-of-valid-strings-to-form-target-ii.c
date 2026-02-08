#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minStickers(char ** stickers, int stickersSize, char * target){
    int n = strlen(target);
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = n + 1;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        if (dp[i] == n + 1) continue;
        for (int j = 0; j < stickersSize; j++) {
            char *sticker = stickers[j];
            int m = strlen(sticker);
            char new_target[n + 1];
            strcpy(new_target, target);
            int k = i;
            while (k < n && m > 0) {
                int found = 0;
                for (int l = 0; l < m; l++) {
                    if (new_target[k] == sticker[l]) {
                        new_target[k] = ' ';
                        found = 1;
                        break;
                    }
                }
                if (found) k++;
                else break;
            }

            dp[k] = (dp[k] > dp[i] + 1) ? dp[i] + 1 : dp[k];
        }
    }

    return (dp[n] > n) ? -1 : dp[n];
}