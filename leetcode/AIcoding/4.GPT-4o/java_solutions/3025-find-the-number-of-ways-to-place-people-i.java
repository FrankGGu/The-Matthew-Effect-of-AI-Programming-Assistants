class Solution {
    public int countWays(int n) {
        final int MOD = 1000000007;
        long[][] dp = new long[n + 1][2];
        dp[0][0] = 1;
        dp[0][1] = 1;

        for (int i = 1; i <= n; i++) {
            dp[i][0] = (dp[i - 1][0] * (2 * i - 1) + dp[i - 1][1] * (i - 1)) % MOD;
            dp[i][1] = (dp[i - 1][0] * (i) + dp[i - 1][1] * (i)) % MOD;
        }

        return (int) ((dp[n][0] + dp[n][1]) % MOD);
    }
}