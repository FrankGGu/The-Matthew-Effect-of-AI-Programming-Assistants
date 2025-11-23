int minimumCoins(int* prices, int pricesSize) {
    int n = pricesSize;
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = 1000000000;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j <= i + i + 2 && j <= n; j++) {
            if (dp[j] > dp[i] + prices[i]) {
                dp[j] = dp[i] + prices[i];
            }
        }
    }

    return dp[n];
}