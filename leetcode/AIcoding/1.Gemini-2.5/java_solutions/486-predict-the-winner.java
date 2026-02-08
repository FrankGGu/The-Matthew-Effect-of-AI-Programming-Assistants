class Solution {
    public boolean PredictTheWinner(int[] nums) {
        int n = nums.length;
        if (n == 0) {
            return true;
        }
        if (n == 1) {
            return true;
        }

        int[][] dp = new int[n][n];

        for (int i = 0; i < n; i++) {
            dp[i][i] = nums[i];
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;

                int pick_i = nums[i] - dp[i + 1][j];
                int pick_j = nums[j] - dp[i][j - 1];

                dp[i][j] = Math.max(pick_i, pick_j);
            }
        }

        return dp[0][n - 1] >= 0;
    }
}