int numberOfSets(int n, int k) {
    int mod = 1e9 + 7;
    long dp[1001][1001] = {0};

    for (int i = 0; i <= n; i++) {
        dp[i][0] = 1;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            dp[i][j] = dp[i-1][j];
            for (int m = 1; m < i; m++) {
                dp[i][j] = (dp[i][j] + dp[m][j-1]) % mod;
            }
        }
    }

    return dp[n][k];
}