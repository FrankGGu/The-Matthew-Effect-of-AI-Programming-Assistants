int numberOfSets(int n, int k) {
    int mod = 1000000007;
    long long dp[k + 1][n + 1];
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }
    dp[0][0] = 1;

    for (int i = 1; i <= k; i++) {
        for (int j = 1; j <= n; j++) {
            dp[i][j] = (dp[i][j - 1] + dp[i - 1][j - 1] * (j - i)) % mod;
        }
    }
    return (int)dp[k][n];
}