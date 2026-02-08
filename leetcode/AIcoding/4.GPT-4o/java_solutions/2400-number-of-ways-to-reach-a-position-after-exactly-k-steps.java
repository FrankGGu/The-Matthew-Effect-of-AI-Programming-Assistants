class Solution {
    public int numberOfWays(int steps, int arrLen) {
        int mod = 1000000007;
        int maxPos = Math.min(steps, arrLen - 1);
        int[][] dp = new int[steps + 1][maxPos + 1];
        dp[0][0] = 1;

        for (int step = 1; step <= steps; step++) {
            for (int pos = 0; pos <= maxPos; pos++) {
                dp[step][pos] = dp[step - 1][pos];
                if (pos > 0) {
                    dp[step][pos] = (dp[step][pos] + dp[step - 1][pos - 1]) % mod;
                }
                if (pos < maxPos) {
                    dp[step][pos] = (dp[step][pos] + dp[step - 1][pos + 1]) % mod;
                }
            }
        }
        return dp[steps][0];
    }
}