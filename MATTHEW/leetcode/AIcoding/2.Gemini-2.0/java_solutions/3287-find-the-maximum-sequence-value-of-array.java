class Solution {
    public long maxScore(int[] nums) {
        int n = nums.length;
        long[] dp = new long[n];
        dp[n - 1] = nums[n - 1];
        long ans = dp[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            dp[i] = nums[i];
            if (nums[i] + dp[i + 1] > nums[i]) {
                dp[i] += dp[i + 1];
            }
            ans = Math.max(ans, dp[i]);
        }
        return ans;
    }
}