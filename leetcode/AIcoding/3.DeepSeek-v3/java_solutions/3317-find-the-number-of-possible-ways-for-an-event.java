class Solution {
    public int numberOfWays(int n, int x) {
        int MOD = 1000000007;
        int[] dp = new int[n + 1];
        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            int power = (int) Math.pow(i, x);
            if (power > n) break;

            for (int j = n; j >= power; j--) {
                dp[j] = (dp[j] + dp[j - power]) % MOD;
            }
        }

        return dp[n];
    }
}