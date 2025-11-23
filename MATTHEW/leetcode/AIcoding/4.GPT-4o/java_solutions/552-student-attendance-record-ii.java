class Solution {
    private static final int MOD = 1000000007;

    public int checkRecord(int n) {
        long[][] dp = new long[n + 1][3];
        dp[0][0] = 1; // 0 A's, 0 L's

        for (int i = 1; i <= n; i++) {
            dp[i][0] = (dp[i - 1][0] + dp[i - 1][1] + dp[i - 1][2]) % MOD; // Add 'P'
            dp[i][1] = dp[i - 1][0]; // Add 'L' after 'P' or 'A'
            dp[i][2] = dp[i - 1][1]; // Add 'L' after 'L' (only one consecutive 'L')
        }

        long result = (dp[n][0] + dp[n][1] + dp[n][2]) % MOD;

        return (int) result;
    }
}