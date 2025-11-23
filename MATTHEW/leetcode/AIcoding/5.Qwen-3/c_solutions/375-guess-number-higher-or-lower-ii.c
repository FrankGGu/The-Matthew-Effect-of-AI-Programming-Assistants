#include <stdio.h>
#include <stdlib.h>

int getMoneyAmount(int n) {
    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
    }

    for (int i = 0; i <= n; i++) {
        dp[i][i] = 0;
    }

    for (int length = 2; length <= n; length++) {
        for (int start = 1; start <= n - length + 1; start++) {
            int end = start + length - 1;
            dp[start][end] = INT_MAX;
            for (int k = start; k <= end; k++) {
                int cost = k + fmax(dp[start][k - 1], dp[k + 1][end]);
                dp[start][end] = fmin(dp[start][end], cost);
            }
        }
    }

    int result = dp[1][n];
    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}