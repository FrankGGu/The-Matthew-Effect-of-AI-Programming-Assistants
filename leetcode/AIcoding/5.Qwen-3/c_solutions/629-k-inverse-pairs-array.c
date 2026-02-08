#include <stdio.h>
#include <stdlib.h>

int** numberOfArrays(int n, int k, int* returnSize, int** returnColumnSizes) {
    int MOD = 1000000007;
    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((k + 1) * sizeof(int));
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }
    dp[0][0] = 1;
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            for (int m = 0; m <= i && j - m >= 0; m++) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j - m]) % MOD;
            }
        }
    }
    *returnSize = n;
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        (*returnColumnSizes)[i] = k + 1;
    }
    return dp;
}