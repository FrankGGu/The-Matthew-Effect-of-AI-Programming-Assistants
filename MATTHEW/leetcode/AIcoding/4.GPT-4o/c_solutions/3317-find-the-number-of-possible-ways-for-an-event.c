int countWays(int n) {
    if (n == 0) return 1;
    if (n == 1) return 1;

    int mod = 1000000007;
    long long dp[n + 1];
    dp[0] = 1;
    dp[1] = 1;

    for (int i = 2; i <= n; i++) {
        dp[i] = (dp[i - 1] + dp[i - 2]) % mod;
    }

    return (int)dp[n];
}