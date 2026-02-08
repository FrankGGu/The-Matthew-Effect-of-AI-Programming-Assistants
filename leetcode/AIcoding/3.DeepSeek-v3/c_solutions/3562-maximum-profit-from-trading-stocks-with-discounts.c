int maxProfit(int* prices, int pricesSize, int* discounts, int discountsSize) {
    int n = pricesSize;
    int m = discountsSize;

    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((m + 1) * sizeof(int));
        for (int j = 0; j <= m; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            dp[i][j] = dp[i - 1][j] + prices[i - 1];
            if (j > 0) {
                int discount = prices[i - 1] - discounts[j - 1];
                if (discount < 0) discount = 0;
                dp[i][j] = fmin(dp[i][j], dp[i - 1][j - 1] + discount);
            }
        }
    }

    int result = dp[n][m];
    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}