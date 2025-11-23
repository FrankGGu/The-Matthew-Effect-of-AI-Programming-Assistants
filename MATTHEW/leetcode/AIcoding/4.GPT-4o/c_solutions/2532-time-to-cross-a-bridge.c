int findCrossingTime(int n, int k, int time[][]) {
    int dp[n + 1][k + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            dp[i][j] = dp[i - 1][j] + time[i - 1][0];
            if (j > 1) {
                dp[i][j] = fmin(dp[i][j], dp[i][j - 1] + time[i - 1][1]);
            }
        }
    }

    return dp[n][k];
}