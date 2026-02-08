int minBeautifulArray(int n) {
    int *dp = (int *)malloc((n + 1) * sizeof(int));
    dp[0] = 0;
    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + i;
    }
    int result = dp[n];
    free(dp);
    return result;
}