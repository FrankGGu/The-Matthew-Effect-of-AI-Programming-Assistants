class Solution {
    private static final int MOD = 1000000007;

    public int numberOfWays(int n, int x) {
        int[] dp = new int[n + 1];
        dp[0] = 1;
        for (int a = 1; ; a++) {
            int power = (int) Math.pow(a, x);
            if (power > n) break;
            for (int i = n; i >= power; i--) {
                dp[i] = (dp[i] + dp[i - power]) % MOD;
            }
        }
        return dp[n];
    }
}