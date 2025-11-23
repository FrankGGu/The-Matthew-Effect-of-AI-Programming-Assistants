#define MOD 1000000007

int numOfWays(int n, int k) {
    long long dp[n + 1][k + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }
    dp[0][0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            dp[i][j] = (dp[i - 1][j - 1] * (i - 1) + dp[i - 1][j] * (i)) % MOD;
        }
    }

    return dp[n][k];
}