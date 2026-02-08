class Solution {
    public int maximumScore(int[] nums, int[] multipliers) {
        int n = nums.length, m = multipliers.length;
        int[][] dp = new int[m + 1][m + 1];

        for (int i = 1; i <= m; i++) {
            for (int j = 0; j <= i; j++) {
                int left = j;
                int right = n - 1 - (i - j);
                if (left < n) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j] + nums[left] * multipliers[i - 1]);
                }
                if (right >= 0) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - 1] + nums[right] * multipliers[i - 1]);
                }
            }
        }

        int maxScore = 0;
        for (int j = 0; j <= m; j++) {
            maxScore = Math.max(maxScore, dp[m][j]);
        }

        return maxScore;
    }
}