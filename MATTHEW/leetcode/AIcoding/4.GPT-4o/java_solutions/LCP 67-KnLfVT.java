class Solution {
    public int countWays(String decorations) {
        int n = decorations.length();
        long mod = 1000000007;
        long[][] dp = new long[n + 1][2];

        dp[0][0] = 1;
        dp[0][1] = 1;

        for (int i = 1; i <= n; i++) {
            if (decorations.charAt(i - 1) == '0') {
                dp[i][0] = dp[i - 1][0] * 2 % mod;
                dp[i][1] = dp[i - 1][1];
            } else {
                dp[i][0] = dp[i - 1][0];
                dp[i][1] = (dp[i - 1][1] * 2 + dp[i - 1][0]) % mod;
            }
        }

        return (int)((dp[n][0] + dp[n][1]) % mod);
    }
}