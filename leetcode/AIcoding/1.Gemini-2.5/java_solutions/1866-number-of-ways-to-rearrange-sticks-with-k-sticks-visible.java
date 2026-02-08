class Solution {
    public int rearrangeSticks(int n, int k) {
        long MOD = 1_000_000_007;
        long[][] dp = new long[n + 1][k + 1];

        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                dp[i][j] = (dp[i - 1][j - 1] + (i - 1L) * dp[i - 1][j]) % MOD;
            }
        }

        return (int) dp[n][k];
    }
}