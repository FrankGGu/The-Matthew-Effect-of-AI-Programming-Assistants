class Solution {
    public int sumOfKSubarrays(int[] nums, int k, int m) {
        int n = nums.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int[] dp = new int[n + 1];
        int res = 0;

        for (int i = m; i <= n; i++) {
            int currentSum = prefixSum[i] - prefixSum[i - m];
            dp[i] = Math.max(dp[i - 1], currentSum);
            if (i >= k * m) {
                res = Math.max(res, dp[i - m] + currentSum);
            }
        }

        return res;
    }
}