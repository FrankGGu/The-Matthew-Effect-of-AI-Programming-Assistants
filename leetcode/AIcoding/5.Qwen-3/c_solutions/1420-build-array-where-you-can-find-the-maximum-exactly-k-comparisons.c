#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int buildArray(int n, int m, int k) {
    int** dp = (int**)malloc(sizeof(int*) * (k + 1));
    for (int i = 0; i <= k; i++) {
        dp[i] = (int*)malloc(sizeof(int) * (n + 1));
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int j = 1; j <= n; j++) {
        dp[0][j] = 1;
    }

    for (int i = 1; i <= k; i++) {
        for (int j = 1; j <= n; j++) {
            for (int l = 1; l <= m; l++) {
                if (j >= l) {
                    dp[i][j] += dp[i - 1][j - 1];
                    dp[i][j] %= 1000000007;
                }
            }
        }
    }

    int result = dp[k][n];
    for (int i = 0; i <= k; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}