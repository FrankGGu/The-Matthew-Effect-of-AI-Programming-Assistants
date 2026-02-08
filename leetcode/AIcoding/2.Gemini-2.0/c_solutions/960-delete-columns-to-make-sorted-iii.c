#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletionSize(char ** strs, int strsSize){
    int n = strsSize;
    int m = strlen(strs[0]);
    int dp[m];
    for (int i = 0; i < m; i++) {
        dp[i] = 1;
    }
    int max_len = 1;
    for (int i = 1; i < m; i++) {
        for (int j = 0; j < i; j++) {
            int sorted = 1;
            for (int k = 0; k < n; k++) {
                if (strs[k][j] > strs[k][i]) {
                    sorted = 0;
                    break;
                }
            }
            if (sorted) {
                dp[i] = (dp[i] > dp[j] + 1) ? dp[i] : (dp[j] + 1);
            }
        }
        max_len = (max_len > dp[i]) ? max_len : dp[i];
    }
    return m - max_len;
}