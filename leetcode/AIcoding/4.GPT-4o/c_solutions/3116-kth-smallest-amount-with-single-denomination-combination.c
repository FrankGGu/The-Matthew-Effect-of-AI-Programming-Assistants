int kthSmallest(int* coins, int coinsSize, int k) {
    int* dp = (int*)calloc(k + 1, sizeof(int));
    dp[0] = 1;
    for (int i = 0; i < coinsSize; i++) {
        for (int j = coins[i]; j <= k; j++) {
            dp[j] += dp[j - coins[i]];
        }
    }
    int count = 0;
    for (int i = 1; i <= k; i++) {
        if (dp[i] > 0) {
            count++;
        }
        if (count == k) {
            free(dp);
            return i;
        }
    }
    free(dp);
    return -1;
}