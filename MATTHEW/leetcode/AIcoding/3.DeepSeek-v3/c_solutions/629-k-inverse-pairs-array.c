int kInversePairs(int n, int k) {
    int mod = 1000000007;
    if (k == 0) return 1;
    if (n == 0) return 0;

    long long dp[n+1][k+1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        dp[i][0] = 1;
    }

    for (int i = 2; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            dp[i][j] = (dp[i][j-1] + dp[i-1][j]) % mod;
            if (j >= i) {
                dp[i][j] = (dp[i][j] - dp[i-1][j-i] + mod) % mod;
            }
        }
    }

    return dp[n][k];
}