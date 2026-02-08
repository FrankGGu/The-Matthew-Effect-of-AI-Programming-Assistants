import java.util.Arrays;

public class Solution {
    public int maxProduct(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[n + 1][k + 1];
        for (int[] row : dp) Arrays.fill(row, Integer.MIN_VALUE);
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                dp[i][j] = dp[i - 1][j];
                if (j >= nums[i - 1]) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - nums[i - 1]] * nums[i - 1]);
                }
            }
        }

        int result = 0;
        for (int j = 0; j <= k; j++) {
            result = Math.max(result, dp[n][j]);
        }

        return result;
    }
}