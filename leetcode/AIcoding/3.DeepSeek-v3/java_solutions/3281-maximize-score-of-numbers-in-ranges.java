class Solution {
    public int maximizeScore(int[] nums, int[][] ranges) {
        int n = nums.length;
        int[][] dp = new int[n][n];
        for (int i = 0; i < n; i++) {
            dp[i][i] = nums[i];
        }
        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                dp[i][j] = Math.max(nums[i] + dp[i + 1][j], nums[j] + dp[i][j - 1]);
            }
        }
        int maxScore = 0;
        for (int[] range : ranges) {
            int start = range[0];
            int end = range[1];
            maxScore += dp[start][end];
        }
        return maxScore;
    }
}