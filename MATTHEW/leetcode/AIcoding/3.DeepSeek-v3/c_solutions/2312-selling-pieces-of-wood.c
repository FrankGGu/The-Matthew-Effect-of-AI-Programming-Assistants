long long sellingWood(int m, int n, int** prices, int pricesSize, int* pricesColSize) {
    long long dp[m+1][n+1];

    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; i < pricesSize; i++) {
        int h = prices[i][0];
        int w = prices[i][1];
        int price = prices[i][2];
        if (h <= m && w <= n) {
            dp[h][w] = price > dp[h][w] ? price : dp[h][w];
        }
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            for (int k = 1; k <= i/2; k++) {
                long long val = dp[k][j] + dp[i-k][j];
                if (val > dp[i][j]) {
                    dp[i][j] = val;
                }
            }
            for (int k = 1; k <= j/2; k++) {
                long long val = dp[i][k] + dp[i][j-k];
                if (val > dp[i][j]) {
                    dp[i][j] = val;
                }
            }
        }
    }

    return dp[m][n];
}