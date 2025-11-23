class Solution {
    public int climbStairs(int n, int k) {
        if (n == 0) return 1;
        if (n < 0) return 0;

        int[] dp = new int[n + 1];
        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                if (i - j >= 0) {
                    dp[i] += dp[i - j];
                }
            }
        }

        return dp[n];
    }
}