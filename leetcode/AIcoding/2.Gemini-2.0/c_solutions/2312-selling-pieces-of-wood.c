#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long sellingWood(int m, int n, int** prices, int pricesSize, int* pricesColSize) {
    long long dp[201][201] = {0};

    for (int i = 0; i < pricesSize; i++) {
        dp[prices[i][0]][prices[i][1]] = prices[i][2];
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            for (int k = 1; k <= i / 2; k++) {
                dp[i][j] = (dp[i][j] > dp[k][j] + dp[i - k][j]) ? dp[i][j] : (dp[k][j] + dp[i - k][j]);
            }
            for (int k = 1; k <= j / 2; k++) {
                dp[i][j] = (dp[i][j] > dp[i][k] + dp[i][j - k]) ? dp[i][j] : (dp[i][k] + dp[i][j - k]);
            }
        }
    }

    return dp[m][n];
}