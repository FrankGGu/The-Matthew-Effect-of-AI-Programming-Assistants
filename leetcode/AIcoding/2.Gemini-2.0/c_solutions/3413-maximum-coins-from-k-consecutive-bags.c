#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxCoins(int** piles, int pilesSize, int* pilesColSize, int k) {
    int n = pilesSize;
    int dp[n + 1][k + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            int current_sum = 0;
            for (int x = 1; x <= pilesColSize[i - 1] && x <= j; x++) {
                current_sum += piles[i - 1][x - 1];
                dp[i][j] = (dp[i][j] > dp[i - 1][j - x] + current_sum) ? dp[i][j] : (dp[i - 1][j - x] + current_sum);
            }
        }
    }

    return dp[n][k];
}