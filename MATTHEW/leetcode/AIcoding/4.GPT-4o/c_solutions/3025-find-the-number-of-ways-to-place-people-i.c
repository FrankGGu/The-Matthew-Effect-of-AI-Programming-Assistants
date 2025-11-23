#define MOD 1000000007

int countWays(int n, int k) {
    if (n == 0) return 1;
    if (k == 0) return 0;

    long long dp[n + 1][k + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i <= k; i++) {
        dp[0][i] = 1;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            dp[i][j] = (dp[i - 1][j - 1] + (j * dp[i - 1][j]) % MOD) % MOD;
        }
    }

    return (int)dp[n][k];
}