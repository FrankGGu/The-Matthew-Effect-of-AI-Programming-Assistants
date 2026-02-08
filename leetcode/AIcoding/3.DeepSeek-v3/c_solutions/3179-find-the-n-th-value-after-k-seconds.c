int valueAfterKSeconds(int n, int k) {
    int mod = 1000000007;
    int dp[n];
    for (int i = 0; i < n; i++) {
        dp[i] = 1;
    }

    for (int t = 0; t < k; t++) {
        for (int i = 1; i < n; i++) {
            dp[i] = (dp[i] + dp[i-1]) % mod;
        }
    }

    return dp[n-1];
}