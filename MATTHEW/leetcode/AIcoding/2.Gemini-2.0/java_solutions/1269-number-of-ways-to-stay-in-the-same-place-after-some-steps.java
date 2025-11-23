class Solution {
    private static final int MOD = 1000000007;

    public int numWays(int steps, int arrLen) {
        int maxPosition = Math.min(steps / 2, arrLen - 1);
        int[][] dp = new int[steps + 1][maxPosition + 1];
        dp[0][0] = 1;

        for (int i = 1; i <= steps; i++) {
            for (int j = 0; j <= maxPosition; j++) {
                dp[i][j] = dp[i - 1][j];
                if (j > 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
                }
                if (j < maxPosition) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % MOD;
                }
            }
        }

        return dp[steps][0];
    }
}