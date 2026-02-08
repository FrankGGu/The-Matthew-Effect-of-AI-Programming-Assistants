class Solution {
    public int maximizeScore(int[] nums, int multipliers) {
        int n = nums.length;
        int[][] dp = new int[multipliers + 1][multipliers + 1];

        for (int i = 0; i < multipliers; i++) {
            for (int j = 0; j <= i; j++) {
                int k = i - j;
                if (j < multipliers) {
                    dp[i + 1][j + 1] = Math.max(dp[i + 1][j + 1], dp[i][j] + nums[j] * nums[n - 1 - k]);
                }
                if (k < multipliers) {
                    dp[i + 1][j] = Math.max(dp[i + 1][j], dp[i][j] + nums[n - 1 - k] * nums[j]);
                }
            }
        }

        int maxScore = 0;
        for (int j = 0; j <= multipliers; j++) {
            maxScore = Math.max(maxScore, dp[multipliers][j]);
        }

        return maxScore;
    }
}