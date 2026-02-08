#define MOD 1000000007

int numDistinctRolls(int n, int k, int target) {
    int dp[n + 1][target + 1];
    memset(dp, 0, sizeof(dp));
    dp[0][0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= target; j++) {
            for (int dice = 1; dice <= k; dice++) {
                if (j - dice >= 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - dice]) % MOD;
                }
            }
        }
    }
    return dp[n][target];
}