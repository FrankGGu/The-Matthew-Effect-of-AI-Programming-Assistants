class Solution {
    private static final int MOD = 1000000007;

    public int numWays(int n) {
        long[] dp = new long[n + 1];
        dp[0] = 1;
        dp[1] = 10;
        if (n > 1) {
            dp[2] = 85;
        }

        for (int i = 3; i <= n; i++) {
            dp[i] = (4 * dp[i - 1] % MOD - 3 * dp[i - 3] % MOD + MOD) % MOD;
        }

        return (int) dp[n];
    }
}