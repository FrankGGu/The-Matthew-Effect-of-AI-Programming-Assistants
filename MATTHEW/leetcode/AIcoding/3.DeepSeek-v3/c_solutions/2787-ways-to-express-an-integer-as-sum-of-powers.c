int numberOfWays(int n, int x) {
    int dp[301] = {0};
    dp[0] = 1;
    int mod = 1000000007;

    for (int i = 1; i <= n; i++) {
        long long power = 1;
        for (int j = 0; j < x; j++) {
            power = (power * i) % mod;
        }
        if (power > n) break;

        for (int j = n; j >= power; j--) {
            dp[j] = (dp[j] + dp[j - power]) % mod;
        }
    }

    return dp[n];
}