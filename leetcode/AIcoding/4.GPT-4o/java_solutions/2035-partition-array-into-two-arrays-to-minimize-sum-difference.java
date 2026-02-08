import java.util.Arrays;

public class Solution {
    public int minimumDifference(int[] nums) {
        int n = nums.length;
        int totalSum = Arrays.stream(nums).sum();
        int half = n / 2;
        int[][] dp = new int[half + 1][totalSum / 2 + 1];
        for (int i = 0; i <= half; i++) {
            Arrays.fill(dp[i], -1);
        }
        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = Math.min(half, i + 1); j > 0; j--) {
                for (int k = totalSum / 2; k >= nums[i]; k--) {
                    if (dp[j - 1][k - nums[i]] != -1) {
                        dp[j][k] = Math.max(dp[j][k], dp[j - 1][k - nums[i]] + nums[i]);
                    }
                }
            }
        }

        int minDiff = Integer.MAX_VALUE;
        for (int i = 0; i <= totalSum / 2; i++) {
            if (dp[half][i] != -1) {
                minDiff = Math.min(minDiff, totalSum - 2 * dp[half][i]);
            }
        }
        return minDiff;
    }
}