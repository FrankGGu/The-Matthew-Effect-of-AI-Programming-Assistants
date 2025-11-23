class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n + 1];
        dp[0] = 0;
        for (int i = 1; i <= n; i++) {
            if (nums[i - 1] == 1) {
                dp[i] = dp[i - 1];
            } else {
                dp[i] = dp[i - 1] + 1;
                if (i >= 2 && nums[i - 2] == 0) {
                    dp[i] = Math.min(dp[i], dp[i - 2] + 1);
                }
            }
        }
        return dp[n];
    }
}