int maxCoins(int** piles, int pilesSize, int* pilesColSize, int k) {
    int n = pilesSize;
    int dp[k + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        int coins = piles[i][0];
        for (int j = 1; j <= pilesColSize[i]; j++) {
            coins += piles[i][j];
            for (int m = k; m >= j; m--) {
                dp[m] = fmax(dp[m], dp[m - j] + coins);
            }
        }
    }

    return dp[k];
}