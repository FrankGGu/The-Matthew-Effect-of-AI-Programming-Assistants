class Solution {
    public int countSubsets(int[] nums, int minSum, int maxSum) {
        int n = nums.length;
        int mod = 1000000007;
        int[][] dp = new int[n + 1][maxSum + 1];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= maxSum; j++) {
                dp[i][j] = dp[i - 1][j];
                if (j >= nums[i - 1]) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - nums[i - 1]]) % mod;
                }
            }
        }

        int result = 0;
        for (int j = minSum; j <= maxSum; j++) {
            result = (result + dp[n][j]) % mod;
        }

        return result;
    }
}