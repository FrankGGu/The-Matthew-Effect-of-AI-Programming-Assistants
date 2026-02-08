class Solution {
    public int countPartitions(int[] nums, int k) {
        long total = 0;
        for (int num : nums) {
            total += num;
        }
        if (total < 2 * k) {
            return 0;
        }

        int n = nums.length;
        int mod = (int)1e9 + 7;
        long[][] dp = new long[n + 1][k];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            int num = nums[i - 1];
            for (int j = 0; j < k; j++) {
                dp[i][j] = dp[i - 1][j];
                if (j >= num) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - num]) % mod;
                }
            }
        }

        long invalid = 0;
        for (int j = 0; j < k; j++) {
            invalid = (invalid + dp[n][j]) % mod;
        }
        invalid = (invalid * 2) % mod;

        long totalPartitions = 1;
        for (int i = 0; i < n; i++) {
            totalPartitions = (totalPartitions * 2) % mod;
        }

        int result = (int)((totalPartitions - invalid + mod) % mod);
        return result;
    }
}