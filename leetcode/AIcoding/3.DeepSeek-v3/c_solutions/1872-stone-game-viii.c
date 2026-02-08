int stoneGameVIII(int* stones, int stonesSize) {
    int n = stonesSize;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + stones[i];
    }

    int* dp = (int*)malloc(n * sizeof(int));
    dp[n - 1] = prefix[n];

    for (int i = n - 2; i >= 1; i--) {
        dp[i] = (prefix[i + 1] - dp[i + 1] > dp[i + 1]) ? prefix[i + 1] - dp[i + 1] : dp[i + 1];
    }

    int result = dp[1];
    free(prefix);
    free(dp);
    return result;
}