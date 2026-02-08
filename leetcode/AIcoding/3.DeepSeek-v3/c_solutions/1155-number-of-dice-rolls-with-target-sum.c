int numRollsToTarget(int n, int k, int target) {
    if (target < n || target > n * k) return 0;

    int MOD = 1000000007;
    long dp[n + 1][target + 1];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= target; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= target; j++) {
            for (int face = 1; face <= k; face++) {
                if (j >= face) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - face]) % MOD;
                }
            }
        }
    }

    return dp[n][target];
}