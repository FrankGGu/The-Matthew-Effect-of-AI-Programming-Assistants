class Solution {
    private static final int MOD = 1000000007;

    public int numberOfWays(int n, int x) {
        int k = (int) (Math.log(n) / Math.log(2) + 1);
        int[] dp = new int[n + 1];
        dp[0] = 1;

        for (int i = 1; (int) Math.pow(i, x) <= n; i++) {
            int power = (int) Math.pow(i, x);
            for (int j = power; j <= n; j++) {
                dp[j] = (dp[j] + dp[j - power]) % MOD;
            }
        }

        return dp[n];
    }
}