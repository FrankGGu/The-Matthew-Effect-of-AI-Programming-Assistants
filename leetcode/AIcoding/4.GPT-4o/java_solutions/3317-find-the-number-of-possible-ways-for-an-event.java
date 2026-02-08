class Solution {
    public int countWays(int[][] ranges) {
        int n = ranges.length;
        int mod = 1000000007;
        long[][] dp = new long[n + 1][2];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            dp[i][0] = (dp[i - 1][0] + dp[i - 1][1]) % mod;
            dp[i][1] = dp[i - 1][0];
            if (i > 1 && ranges[i - 1][0] <= ranges[i - 2][1]) {
                dp[i][1] = (dp[i][1] + dp[i - 1][1]) % mod;
            }
        }

        return (int)(dp[n][0] + dp[n][1]) % mod;
    }
}