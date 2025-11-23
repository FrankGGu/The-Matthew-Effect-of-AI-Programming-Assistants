class Solution {
    public int maximumScore(int[] nums, int[] multipliers) {
        int n = nums.length;
        int m = multipliers.length;
        int[][] dp = new int[m + 1][m + 1];

        for (int i = 1; i <= m; i++) {
            for (int left = 0; left <= i; left++) {
                int right = i - left;
                if (left > 0) {
                    dp[i][left] = Math.max(dp[i][left], dp[i - 1][left - 1] + nums[left - 1] * multipliers[i - 1]);
                }
                if (right > 0) {
                    dp[i][left] = Math.max(dp[i][left], dp[i - 1][left] + nums[n - right] * multipliers[i - 1]);
                }
            }
        }

        return dp[m][0];
    }
}