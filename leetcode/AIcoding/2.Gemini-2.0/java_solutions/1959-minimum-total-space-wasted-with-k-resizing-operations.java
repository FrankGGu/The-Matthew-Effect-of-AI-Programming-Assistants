import java.util.Arrays;

class Solution {
    public int minSpaceWastedKResizing(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[n + 1][k + 2];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2);
        }
        dp[0][0] = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= k + 1; j++) {
                int maxVal = 0;
                int sum = 0;
                for (int l = i; l >= 1; l--) {
                    maxVal = Math.max(maxVal, nums[l - 1]);
                    sum += nums[l - 1];
                    int wasted = maxVal * (i - l + 1) - sum;
                    if (j > 0) {
                        dp[i][j] = Math.min(dp[i][j], dp[l - 1][j - 1] + wasted);
                    } else if (l == 1 && j == 0) {
                        dp[i][j] = wasted;
                    }
                }
            }
        }
        return dp[n][k + 1];
    }
}