class Solution {
    public int numOfWays(int n) {
        long mod = 1000000007;
        long[][] dp = new long[n + 1][2];
        dp[0][0] = 1;
        dp[0][1] = 0;

        for (int i = 1; i <= n; i++) {
            dp[i][0] = (dp[i - 1][0] * 3 + dp[i - 1][1] * 2) % mod;
            dp[i][1] = (dp[i - 1][0] * 2 + dp[i - 1][1] * 2) % mod;
        }

        return (int)((dp[n][0] + dp[n][1]) % mod);
    }
}