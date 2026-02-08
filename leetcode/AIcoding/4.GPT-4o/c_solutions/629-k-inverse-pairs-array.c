int kInversePairs(int n, int k) {
    int mod = 1000000007;
    int dp[n + 1][k + 1];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            for (int x = 0; x <= j && x < i; x++) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j - x]) % mod;
            }
        }
    }

    return dp[n][k];
}