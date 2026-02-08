#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int minDeletionSize(char** strs, int strsSize) {
    int len = strlen(strs[0]);
    int dp[strsSize][len];
    memset(dp, 0, sizeof(dp));

    for (int j = 0; j < len; j++) {
        for (int i = 0; i < strsSize; i++) {
            dp[i][j] = 1;
            if (i > 0) {
                for (int k = 0; k < i; k++) {
                    if (strs[k][j] <= strs[i][j]) {
                        if (j > 0) {
                            dp[i][j] = min(dp[i][j], dp[k][j] + 1);
                        } else {
                            dp[i][j] = min(dp[i][j], 1 + 1);
                        }
                    }
                }
            }
        }
    }

    int max_len = 0;
    for (int i = 0; i < strsSize; i++) {
        for (int j = 0; j < len; j++) {
            max_len = max(max_len, dp[i][j]);
        }
    }

    return strsSize - max_len;
}