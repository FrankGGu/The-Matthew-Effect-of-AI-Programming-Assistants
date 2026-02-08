class Solution {
    public int minNumberGame(int[] nums) {
        int n = nums.length;
        if (n == 0) return 0;
        int[] dp = new int[n];
        for (int i = 0; i < n; i++) {
            dp[i] = nums[i];
        }
        for (int i = 1; i < n; i += 2) {
            dp[i] = Math.min(dp[i - 1], dp[i]);
        }
        for (int i = 2; i < n; i += 2) {
            dp[i] = Math.max(dp[i - 1], dp[i]);
        }
        return dp[n - 1];
    }
}