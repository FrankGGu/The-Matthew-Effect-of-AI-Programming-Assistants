class Solution {
    public long maximumStrength(int[] nums, int k) {
        int n = nums.length;
        long[][] dp = new long[n + 1][k + 1];
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        for (int j = 1; j <= k; j++) {
            long maxPrev = Long.MIN_VALUE;
            long multiplier = (j % 2 == 1) ? (k - j + 1) : -(k - j + 1);
            for (int i = j; i <= n; i++) {
                if (j == 1) {
                    dp[i][j] = Math.max(dp[i - 1][j] + nums[i - 1] * multiplier, nums[i - 1] * multiplier);
                } else {
                    maxPrev = Math.max(maxPrev, dp[i - 1][j - 1] - prefix[i - 1] * multiplier);
                    dp[i][j] = Math.max(dp[i - 1][j] + nums[i - 1] * multiplier, prefix[i] * multiplier + maxPrev);
                }
            }
        }

        long res = Long.MIN_VALUE;
        for (int i = k; i <= n; i++) {
            res = Math.max(res, dp[i][k]);
        }
        return res;
    }
}