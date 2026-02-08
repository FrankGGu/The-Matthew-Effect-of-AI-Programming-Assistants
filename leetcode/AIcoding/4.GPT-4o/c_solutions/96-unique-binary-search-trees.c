int numTrees(int n) {
    int *dp = (int *)malloc((n + 1) * sizeof(int));
    dp[0] = 1;
    dp[1] = 1;

    for (int i = 2; i <= n; i++) {
        dp[i] = 0;
        for (int j = 0; j < i; j++) {
            dp[i] += dp[j] * dp[i - 1 - j];
        }
    }

    int result = dp[n];
    free(dp);
    return result;
}