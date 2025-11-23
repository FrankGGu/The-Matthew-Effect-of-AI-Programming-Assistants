int maxProfit(int* prices, int pricesSize) {
    if (pricesSize == 0) return 0;

    int dp[3][pricesSize];

    for (int k = 1; k <= 2; k++) {
        int maxDiff = -prices[0];
        for (int i = 1; i < pricesSize; i++) {
            dp[k][i] = dp[k][i - 1] > prices[i] + maxDiff ? dp[k][i - 1] : prices[i] + maxDiff;
            maxDiff = maxDiff > dp[k - 1][i] - prices[i] ? maxDiff : dp[k - 1][i] - prices[i];
        }
    }

    return dp[2][pricesSize - 1];
}