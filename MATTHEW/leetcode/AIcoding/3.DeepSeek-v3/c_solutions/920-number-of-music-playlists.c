int numMusicPlaylists(int n, int goal, int k) {
    long long dp[goal + 1][n + 1];
    int mod = 1e9 + 7;

    for (int i = 0; i <= goal; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int i = 1; i <= goal; i++) {
        for (int j = 1; j <= n; j++) {
            dp[i][j] = (dp[i][j] + dp[i - 1][j - 1] * (n - j + 1)) % mod;
            if (j > k) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j] * (j - k)) % mod;
            }
        }
    }

    return dp[goal][n];
}