class Solution {
    public long maxStrength(int[] nums, int k) {
        int n = nums.length;
        long[][] dp = new long[k + 1][n + 1];
        for (int i = 0; i <= k; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = Long.MIN_VALUE;
            }
        }
        dp[0][0] = 1;

        for (int i = 1; i <= k; i++) {
            for (int j = i; j <= n; j++) {
                dp[i][j] = Math.max(dp[i][j - 1], dp[i - 1][j - 1] * nums[j - 1]);
                if (nums[j - 1] == 0 && dp[i][j] < 0) {
                    dp[i][j] = 0;
                }
            }
        }
        return dp[k][n];
    }
}