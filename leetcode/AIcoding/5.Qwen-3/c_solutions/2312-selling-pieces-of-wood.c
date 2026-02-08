#include <stdio.h>
#include <stdlib.h>

int sellingWood(int n, int m, int** prices) {
    int dp[n + 1][m + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; prices[i]; i++) {
        int x = prices[i][0];
        int y = prices[i][1];
        int val = prices[i][2];
        dp[x][y] = val;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            for (int k = 1; k < i; k++) {
                dp[i][j] = fmax(dp[i][j], dp[k][j] + dp[i - k][j]);
            }
            for (int l = 1; l < j; l++) {
                dp[i][j] = fmax(dp[i][j], dp[i][l] + dp[i][j - l]);
            }
        }
    }

    return dp[n][m];
}