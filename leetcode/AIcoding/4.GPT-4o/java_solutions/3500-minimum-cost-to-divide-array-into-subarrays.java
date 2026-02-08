class Solution {
    public int minCost(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                dp[i][j] = Integer.MAX_VALUE / 2;
            }
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                int[] count = new int[101];
                int unique = 0;
                for (int p = i; p >= 1; p--) {
                    if (count[nums[p - 1]] == 0) unique++;
                    count[nums[p - 1]]++;
                    dp[i][j] = Math.min(dp[i][j], dp[p - 1][j - 1] + unique);
                }
            }
        }

        return dp[n][k];
    }
}