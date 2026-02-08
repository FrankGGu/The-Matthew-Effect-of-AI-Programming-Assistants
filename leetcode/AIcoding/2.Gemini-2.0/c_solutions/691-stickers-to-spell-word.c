#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minStickers(char** stickers, int stickersSize, char* target) {
    int n = strlen(target);
    int dp[1 << n];
    for (int i = 0; i < (1 << n); i++) {
        dp[i] = -1;
    }
    dp[0] = 0;

    for (int mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] == -1) continue;

        for (int i = 0; i < stickersSize; i++) {
            char* sticker = stickers[i];
            int len = strlen(sticker);
            int newMask = mask;
            int counts[26] = {0};
            for (int j = 0; j < len; j++) {
                counts[sticker[j] - 'a']++;
            }

            for (int j = 0; j < n; j++) {
                if (!(newMask & (1 << j))) {
                    if (counts[target[j] - 'a'] > 0) {
                        counts[target[j] - 'a']--;
                        newMask |= (1 << j);
                    }
                }
            }

            if (dp[newMask] == -1 || dp[newMask] > dp[mask] + 1) {
                dp[newMask] = dp[mask] + 1;
            }
        }
    }

    return dp[(1 << n) - 1];
}