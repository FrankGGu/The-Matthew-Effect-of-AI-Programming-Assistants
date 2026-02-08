int peopleAwareOfSecret(int n, int delay, int forget) {
    long dp[n+1];
    for (int i = 0; i <= n; i++) dp[i] = 0;
    dp[1] = 1;
    long share = 0;
    long mod = 1000000007;

    for (int i = 2; i <= n; i++) {
        if (i - delay >= 1) {
            share = (share + dp[i - delay]) % mod;
        }
        if (i - forget >= 1) {
            share = (share - dp[i - forget] + mod) % mod;
        }
        dp[i] = share;
    }

    long result = 0;
    for (int i = n - forget + 1; i <= n; i++) {
        result = (result + dp[i]) % mod;
    }
    return result;
}