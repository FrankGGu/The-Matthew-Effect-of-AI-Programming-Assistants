class Solution {
    public int minimumArraySum(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n];
        dp[0] = nums[0];
        for (int i = 1; i < n; i++) {
            dp[i] = dp[i - 1] + nums[i];
            for (int j = 0; j < i; j++) {
                if (nums[i] >= nums[j]) {
                    dp[i] = Math.min(dp[i], dp[j] + (dp[i - 1] - dp[j] + nums[i]));
                }
            }
        }
        return dp[n - 1];
    }
}