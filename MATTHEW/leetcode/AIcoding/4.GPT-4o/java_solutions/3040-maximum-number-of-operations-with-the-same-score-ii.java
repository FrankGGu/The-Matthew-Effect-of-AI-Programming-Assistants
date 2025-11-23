class Solution {
    public int maximumOperations(int[] nums, int target) {
        int n = nums.length;
        int[][] dp = new int[n + 1][target + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= target; j++) {
                dp[i][j] = (i == 0) ? 0 : dp[i - 1][j];
                if (i > 0 && j >= nums[i - 1]) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - nums[i - 1]] + 1);
                }
            }
        }
        return dp[n][target];
    }
}