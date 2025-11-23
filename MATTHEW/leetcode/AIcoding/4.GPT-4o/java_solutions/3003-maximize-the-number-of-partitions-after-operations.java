class Solution {
    public int maximizePartitions(int[] nums, int k) {
        int n = nums.length;
        long[] dp = new long[n + 1];
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];
            if (nums[i - 1] > k) {
                long extra = (long) nums[i - 1] - k;
                dp[i] += extra;
            }
        }

        int partitions = 0;
        for (int i = 0; i <= n; i++) {
            if (dp[i] <= k) {
                partitions++;
            }
        }

        return partitions;
    }
}