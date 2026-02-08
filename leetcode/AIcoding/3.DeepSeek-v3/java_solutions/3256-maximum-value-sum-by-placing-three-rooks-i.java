class Solution {
    public long maximumValueSum(int[] nums, int k, int[][] edges) {
        int n = nums.length;
        long[][] dp = new long[n + 1][4];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Long.MIN_VALUE);
        }
        dp[0][0] = 0;
        for (int i = 0; i < n; i++) {
            for (int mask = 0; mask < 4; mask++) {
                if (dp[i][mask] == Long.MIN_VALUE) continue;
                int newMask = mask;
                dp[i + 1][newMask] = Math.max(dp[i + 1][newMask], dp[i][mask] + nums[i]);
                newMask = mask ^ 1;
                dp[i + 1][newMask] = Math.max(dp[i + 1][newMask], dp[i][mask] + (nums[i] ^ k));
            }
        }
        return dp[n][3];
    }
}