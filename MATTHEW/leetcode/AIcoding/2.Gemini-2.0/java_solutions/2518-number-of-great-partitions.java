class Solution {
    public int countPartitions(int[] nums, int k) {
        int n = nums.length;
        long sum = 0;
        for (int num : nums) {
            sum += num;
        }

        if (sum < 2 * k) {
            return 0;
        }

        int mod = 1000000007;
        long[] dp = new long[k];
        dp[0] = 1;

        for (int num : nums) {
            for (int j = k - 1; j >= num; j--) {
                dp[j] = (dp[j] + dp[j - num]) % mod;
            }
        }

        long totalSubsets = 1;
        for (int i = 0; i < n; i++) {
            totalSubsets = (totalSubsets * 2) % mod;
        }

        long invalidSubsets = 0;
        for (int i = 0; i < k; i++) {
            invalidSubsets = (invalidSubsets + dp[i]) % mod;
        }

        long result = (totalSubsets - 2 * invalidSubsets % mod + mod) % mod;
        return (int) result;
    }
}