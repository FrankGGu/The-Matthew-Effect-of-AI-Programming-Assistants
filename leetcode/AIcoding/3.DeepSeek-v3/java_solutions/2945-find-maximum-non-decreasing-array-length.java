class Solution {
    public int findMaximumNonDecreasingArrayLength(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }
        int n = nums.length;
        int[] dp = new int[n];
        dp[0] = 1;
        int maxLen = 1;

        for (int i = 1; i < n; i++) {
            if (nums[i] >= nums[i - 1]) {
                dp[i] = dp[i - 1] + 1;
            } else {
                dp[i] = 1;
            }
            maxLen = Math.max(maxLen, dp[i]);
        }
        return maxLen;
    }
}