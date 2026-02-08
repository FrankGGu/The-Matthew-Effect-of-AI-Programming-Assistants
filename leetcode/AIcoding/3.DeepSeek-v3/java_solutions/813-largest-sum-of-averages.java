class Solution {
    public double largestSumOfAverages(int[] nums, int k) {
        int n = nums.length;
        double[] prefix = new double[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        double[][] dp = new double[n + 1][k + 1];
        for (int i = 1; i <= n; i++) {
            dp[i][1] = prefix[i] / i;
        }
        for (int j = 2; j <= k; j++) {
            for (int i = j; i <= n; i++) {
                for (int m = j - 1; m < i; m++) {
                    dp[i][j] = Math.max(dp[i][j], dp[m][j - 1] + (prefix[i] - prefix[m]) / (i - m));
                }
            }
        }
        return dp[n][k];
    }
}