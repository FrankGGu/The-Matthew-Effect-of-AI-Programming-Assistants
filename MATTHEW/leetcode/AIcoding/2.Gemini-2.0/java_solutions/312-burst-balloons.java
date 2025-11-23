class Solution {
    public int maxCoins(int[] nums) {
        int n = nums.length;
        int[] paddedNums = new int[n + 2];
        paddedNums[0] = paddedNums[n + 1] = 1;
        for (int i = 1; i <= n; i++) {
            paddedNums[i] = nums[i - 1];
        }

        int[][] dp = new int[n + 2][n + 2];

        for (int len = 2; len <= n + 1; len++) {
            for (int i = 0; i <= n - len + 1; i++) {
                int j = i + len;
                for (int k = i + 1; k < j; k++) {
                    dp[i][j] = Math.max(dp[i][j], dp[i][k] + dp[k][j] + paddedNums[i] * paddedNums[k] * paddedNums[j]);
                }
            }
        }

        return dp[0][n + 1];
    }
}