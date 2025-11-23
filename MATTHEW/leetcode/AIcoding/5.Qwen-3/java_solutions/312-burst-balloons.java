public class Solution {
    public int burstBalloon(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[n][n];

        for (int length = 1; length <= n; length++) {
            for (int left = 0; left <= n - length; left++) {
                int right = left + length - 1;
                int last = 0;
                if (left > 0) last = nums[left - 1];
                if (right < n - 1) last += nums[right + 1];
                for (int i = left; i <= right; i++) {
                    int leftVal = 0;
                    if (i > left) leftVal = dp[left][i - 1];
                    int rightVal = 0;
                    if (i < right) rightVal = dp[i + 1][right];
                    int current = nums[i] * last + leftVal + rightVal;
                    dp[left][right] = Math.max(dp[left][right], current);
                }
            }
        }

        return dp[0][n - 1];
    }

    public int maxCoins(int[] nums) {
        return burstBalloon(nums);
    }
}