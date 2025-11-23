int minCoins(int* coins, int coinsSize, int amount) {
    int dp[amount + 1];
    for (int i = 0; i <= amount; i++) {
        dp[i] = amount + 1;
    }
    dp[0] = 0;

    for (int i = 1; i <= amount; i++) {
        for (int j = 0; j < coinsSize; j++) {
            if (i >= coins[j]) {
                dp[i] = fmin(dp[i], dp[i - coins[j]] + 1);
            }
        }
    }

    return dp[amount] == amount + 1 ? -1 : dp[amount];
}