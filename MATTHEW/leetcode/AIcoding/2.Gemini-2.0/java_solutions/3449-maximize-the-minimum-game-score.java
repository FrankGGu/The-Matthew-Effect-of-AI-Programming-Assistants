import java.util.Arrays;

class Solution {
    public long maximizeTheMinimumGameScore(int[] nums, int k) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        long[][] dp = new long[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], -1);
        }

        return solve(nums, k, 0, n, prefixSum, dp);
    }

    private long solve(int[] nums, int k, int index, int n, long[] prefixSum, long[][] dp) {
        if (k == 0) {
            if (index == n) {
                return Long.MAX_VALUE;
            } else {
                return -1;
            }
        }

        if (index >= n) {
            return -1;
        }

        if (dp[index][k] != -1) {
            return dp[index][k];
        }

        long ans = -1;
        for (int i = index; i < n; i++) {
            long currentSum = prefixSum[i + 1] - prefixSum[index];
            long next = solve(nums, k - 1, i + 1, n, prefixSum, dp);
            if (next != -1) {
                if (ans == -1) {
                    ans = Math.min(currentSum, next);
                } else {
                    ans = Math.max(ans, Math.min(currentSum, next));
                }
            }
        }

        return dp[index][k] = ans;
    }
}