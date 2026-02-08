class Solution {
    public int maximumScore(int[] nums, int[] multipliers) {
        int n = nums.length, m = multipliers.length;
        int[][] dp = new int[m + 1][m + 1];

        for (int i = 1; i <= m; i++) {
            for (int j = 0; j <= i; j++) {
                int left = dp[i - 1][j] + nums[j] * multipliers[i - 1];
                int right = dp[i - 1][j - 1] + nums[n - (i - j)] * multipliers[i - 1];
                dp[i][j] = Math.max(left, right);
            }
        }

        int maxScore = 0;
        for (int j = 0; j <= m; j++) {
            maxScore = Math.max(maxScore, dp[m][j]);
        }

        return maxScore;
    }
}