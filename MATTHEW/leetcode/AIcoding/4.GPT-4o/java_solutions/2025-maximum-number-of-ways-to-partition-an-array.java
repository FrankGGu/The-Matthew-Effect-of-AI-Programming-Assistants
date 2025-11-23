class Solution {
    public int countPartitions(int[] nums, int k) {
        int mod = 1000000007;
        int n = nums.length;
        long totalSum = 0;
        for (int num : nums) totalSum += num;
        if (totalSum < k) return 0;

        long target = (totalSum - k) / 2;
        if ((totalSum - k) % 2 != 0) return 0;

        long[] dp = new long[(int)target + 1];
        dp[0] = 1;

        for (int num : nums) {
            for (int j = (int)target; j >= num; j--) {
                dp[j] = (dp[j] + dp[j - num]) % mod;
            }
        }

        long result = 0;
        for (int j = 0; j <= target; j++) {
            result = (result + dp[j]) % mod;
        }

        return (int)result;
    }
}