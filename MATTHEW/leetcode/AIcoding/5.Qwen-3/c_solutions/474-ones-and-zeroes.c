#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findMaxForm(char **strs, int strsSize, int m, int n) {
    int dp[m+1][n+1];
    memset(dp, 0, sizeof(dp));

    for (int k = 0; k < strsSize; k++) {
        int zeros = 0, ones = 0;
        for (int i = 0; i < strlen(strs[k]); i++) {
            if (strs[k][i] == '0') zeros++;
            else ones++;
        }

        for (int i = m; i >= zeros; i--) {
            for (int j = n; j >= ones; j--) {
                dp[i][j] = fmax(dp[i][j], dp[i - zeros][j - ones] + 1);
            }
        }
    }

    return dp[m][n];
}