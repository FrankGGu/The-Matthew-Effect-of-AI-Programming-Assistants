public class Solution {
    public int maximumScore(int[] nums, int[] multipliers) {
        int n = nums.length;
        int m = multipliers.length;
        int[][] dp = new int[m + 1][m + 1];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j <= i; j++) {
                int k = i - j;
                if (k >= n) break;
                dp[i + 1][j + 1] = Math.max(dp[i][j] + nums[j] * multipliers[i], dp[i][j + 1] + nums[n - k - 1] * multipliers[i]);
            }
        }

        int maxScore = 0;
        for (int i = 0; i <= m; i++) {
            maxScore = Math.max(maxScore, dp[m][i]);
        }
        return maxScore;
    }
}