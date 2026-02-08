int maxTaxiEarnings(int n, int** rides, int ridesSize, int* ridesColSize) {
    long dp[n + 1];
    memset(dp, 0, sizeof(dp));
    for (int i = 0; i < ridesSize; i++) {
        int start = rides[i][0], end = rides[i][1], tip = rides[i][2];
        dp[end] = fmax(dp[end], dp[start] + end - start + tip);
    }
    for (int i = 1; i <= n; i++) {
        dp[i] = fmax(dp[i], dp[i - 1]);
    }
    return dp[n];
}