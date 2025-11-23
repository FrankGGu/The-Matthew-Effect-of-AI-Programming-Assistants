class Solution {
    private static final int MOD = 1000000007;

    public int countPartitions(int[] nums, int k) {
        long sum = 0;
        for (int num : nums) {
            sum += num;
        }

        if (sum % 2 != 0) {
            return 0;
        }

        long target = sum / 2;
        if (target < k) {
            return 0;
        }

        int n = nums.length;
        long[] dp = new long[(int) target + 1];
        dp[0] = 1;

        for (int num : nums) {
            for (int j = (int) target; j >= num; j--) {
                dp[j] = (dp[j] + dp[j - num]) % MOD;
            }
        }

        long totalSubsets = dp[(int) target];
        long totalWays = 1;
        for (int i = 0; i < n; i++) {
            totalWays = (totalWays * 2) % MOD;
        }

        long invalidWays = (totalWays - totalSubsets + MOD) % MOD;

        return (int) ((totalWays - 2 * invalidWays + 2 * MOD) % MOD);
    }
}