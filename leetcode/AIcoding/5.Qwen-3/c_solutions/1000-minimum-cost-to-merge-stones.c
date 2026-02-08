#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minCost(int* stones, int stonesSize) {
    int n = stonesSize;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; ++i)
        prefix[i + 1] = prefix[i] + stones[i];

    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; ++i)
        dp[i] = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; ++i)
        for (int j = 0; j < n; ++j)
            dp[i][j] = 0;

    for (int k = 2; k <= n; ++k) {
        for (int i = 0; i <= n - k; ++i) {
            int j = i + k - 1;
            dp[i][j] = INT_MAX;
            for (int m = i; m < j; ++m) {
                int cost = dp[i][m] + dp[m + 1][j];
                if ((j - i + 1) % 3 == 1) {
                    cost += prefix[j + 1] - prefix[i];
                }
                dp[i][j] = (cost < dp[i][j]) ? cost : dp[i][j];
            }
        }
    }

    int result = dp[0][n - 1];
    free(prefix);
    for (int i = 0; i < n; ++i)
        free(dp[i]);
    free(dp);
    return result;
}