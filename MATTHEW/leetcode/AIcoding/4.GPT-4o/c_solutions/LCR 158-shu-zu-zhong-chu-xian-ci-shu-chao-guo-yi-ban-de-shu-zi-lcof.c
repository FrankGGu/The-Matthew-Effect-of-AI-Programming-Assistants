int maxProfit(int k, int* prices, int pricesSize) {
    if (pricesSize == 0) return 0;
    if (k >= pricesSize / 2) {
        int profit = 0;
        for (int i = 1; i < pricesSize; i++) {
            if (prices[i] > prices[i - 1]) {
                profit += prices[i] - prices[i - 1];
            }
        }
        return profit;
    }

    int** dp = (int**)malloc((k + 1) * sizeof(int*));
    for (int i = 0; i <= k; i++) {
        dp[i] = (int*)malloc(pricesSize * sizeof(int));
    }

    for (int i = 0; i <= k; i++) {
        dp[i][0] = 0;
    }
    for (int j = 0; j < pricesSize; j++) {
        dp[0][j] = 0;
    }

    for (int i = 1; i <= k; i++) {
        int maxDiff = -prices[0];
        for (int j = 1; j < pricesSize; j++) {
            dp[i][j] = fmax(dp[i][j - 1], prices[j] + maxDiff);
            maxDiff = fmax(maxDiff, dp[i - 1][j] - prices[j]);
        }
    }

    int result = dp[k][pricesSize - 1];

    for (int i = 0; i <= k; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}