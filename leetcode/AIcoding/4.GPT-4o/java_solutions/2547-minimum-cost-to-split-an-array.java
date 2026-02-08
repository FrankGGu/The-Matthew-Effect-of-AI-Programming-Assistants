class Solution {
    public int minCost(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[n + 1][k + 1];
        int[] count = new int[n + 1];

        for (int i = 1; i <= n; i++) {
            count[i] = count[i - 1] + (i == 1 || nums[i - 1] != nums[i - 2] ? 1 : 0);
        }

        for (int j = 1; j <= k; j++) {
            for (int i = 1; i <= n; i++) {
                dp[i][j] = Integer.MAX_VALUE;
                for (int p = 0; p < i; p++) {
                    dp[i][j] = Math.min(dp[i][j], dp[p][j - 1] + count[i] - count[p]);
                }
            }
        }

        return dp[n][k];
    }
}