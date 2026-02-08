class Solution {
    public int numRollsToTarget(int n, int f, int target) {
        int MOD = 1_000_000_007;

        long[][] dp = new long[n + 1][target + 1];

        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= target; j++) {
                for (int k = 1; k <= f; k++) {
                    if (j - k >= 0) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][j - k]) % MOD;
                    }
                }
            }
        }

        return (int) dp[n][target];
    }
}