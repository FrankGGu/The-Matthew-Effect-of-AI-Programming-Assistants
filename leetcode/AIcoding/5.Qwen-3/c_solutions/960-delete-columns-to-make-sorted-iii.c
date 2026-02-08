#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletionSize(char **strs, int strsSize) {
    int n = strsSize;
    int m = strlen(strs[0]);
    int dp[m];
    for (int i = 0; i < m; i++) {
        dp[i] = 1;
    }
    for (int j = 0; j < m; j++) {
        for (int k = 0; k < j; k++) {
            int valid = 1;
            for (int i = 0; i < n; i++) {
                if (strs[i][k] > strs[i][j]) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                dp[j] = fmax(dp[j], dp[k] + 1);
            }
        }
    }
    int max = 0;
    for (int i = 0; i < m; i++) {
        max = fmax(max, dp[i]);
    }
    return m - max;
}