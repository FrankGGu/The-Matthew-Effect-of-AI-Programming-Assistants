class Solution {
    public int maximumLength(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[n][k + 1];
        int[][] maxLen = new int[k + 1][2];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= k; j++) {
                dp[i][j] = 1;
                if (j > 0) {
                    dp[i][j] = Math.max(dp[i][j], maxLen[j - 1][0] + 1);
                }
                if (i > 0 && nums[i] == nums[i - 1]) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j] + 1);
                }
                if (dp[i][j] > maxLen[j][0]) {
                    maxLen[j][1] = maxLen[j][0];
                    maxLen[j][0] = dp[i][j];
                } else if (dp[i][j] > maxLen[j][1]) {
                    maxLen[j][1] = dp[i][j];
                }
            }
        }

        int res = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= k; j++) {
                res = Math.max(res, dp[i][j]);
            }
        }
        return res;
    }
}