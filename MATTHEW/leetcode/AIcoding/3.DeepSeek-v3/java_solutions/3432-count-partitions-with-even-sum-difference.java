class Solution {
    public int countPartitions(int[] nums) {
        int MOD = 1_000_000_007;
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }
        if (totalSum % 2 != 0) {
            return 0;
        }
        int target = totalSum / 2;
        int n = nums.length;
        int[][] dp = new int[n + 1][target + 1];
        dp[0][0] = 1;
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= target; j++) {
                dp[i][j] = dp[i - 1][j];
                if (j >= nums[i - 1]) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - nums[i - 1]]) % MOD;
                }
            }
        }
        return dp[n][target];
    }
}