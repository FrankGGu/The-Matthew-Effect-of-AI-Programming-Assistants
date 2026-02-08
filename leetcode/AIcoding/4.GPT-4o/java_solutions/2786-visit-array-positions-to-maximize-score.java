class Solution {
    public int maxScore(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[n + 1][n / 2 + 1];
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= Math.min(i / 2, n / 2); j++) {
                dp[i][j] = Math.max(dp[i - 1][j], dp[i - 1][j - 1] + i * nums[i - 1]);
            }
        }
        return dp[n][n / 2];
    }
}