public class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[n + 1][2];

        for (int i = 1; i <= n; i++) {
            dp[i][0] = dp[i - 1][0] + (nums[i - 1] == 1 ? 0 : 1);
            dp[i][1] = Math.min(dp[i - 1][0] + (nums[i - 1] == 2 ? 0 : 1), dp[i - 1][1] + (nums[i - 1] == 1 ? 0 : 1));
        }

        return Math.min(dp[n][0], dp[n][1]);
    }
}