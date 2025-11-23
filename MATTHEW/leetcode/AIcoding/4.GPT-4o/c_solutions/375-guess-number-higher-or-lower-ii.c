int getMoneyAmount(int n) {
    int dp[n + 1][n + 1];
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 1; i <= n - len + 1; i++) {
            int j = i + len - 1;
            dp[i][j] = INT_MAX;
            for (int k = i; k < j; k++) {
                int cost = k + fmax(dp[i][k - 1], dp[k + 1][j]);
                dp[i][j] = fmin(dp[i][j], cost);
            }
        }
    }

    return dp[1][n];
}