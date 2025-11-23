int coinChange(int* coins, int coinsSize, int amount) {
    int* dp = (int*)malloc((amount + 1) * sizeof(int));
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

    int result = dp[amount];
    free(dp);
    return result == amount + 1 ? -1 : result;
}