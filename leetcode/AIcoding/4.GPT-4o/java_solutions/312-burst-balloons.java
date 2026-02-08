class Solution {
    public int maxCoins(int[] nums) {
        int n = nums.length;
        int[] balloons = new int[n + 2];
        balloons[0] = 1;
        balloons[n + 1] = 1;
        for (int i = 0; i < n; i++) {
            balloons[i + 1] = nums[i];
        }

        int[][] dp = new int[n + 2][n + 2];
        for (int length = 1; length <= n; length++) {
            for (int left = 1; left <= n - length + 1; left++) {
                int right = left + length - 1;
                for (int i = left; i <= right; i++) {
                    dp[left][right] = Math.max(dp[left][right], 
                        dp[left][i - 1] + dp[i + 1][right] + balloons[left - 1] * balloons[i] * balloons[right + 1]);
                }
            }
        }
        return dp[1][n];
    }
}