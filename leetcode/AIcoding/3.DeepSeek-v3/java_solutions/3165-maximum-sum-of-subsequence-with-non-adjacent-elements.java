class Solution {
    public int maximumSumSubsequence(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }
        int n = nums.length;
        if (n == 1) {
            return Math.max(nums[0], 0);
        }
        int[] dp = new int[n];
        dp[0] = Math.max(nums[0], 0);
        dp[1] = Math.max(dp[0], Math.max(nums[1], 0));
        for (int i = 2; i < n; i++) {
            dp[i] = Math.max(dp[i - 1], dp[i - 2] + Math.max(nums[i], 0));
        }
        return dp[n - 1];
    }
}