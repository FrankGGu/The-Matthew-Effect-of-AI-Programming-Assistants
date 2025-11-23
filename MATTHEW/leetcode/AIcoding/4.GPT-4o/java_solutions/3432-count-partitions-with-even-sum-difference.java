class Solution {
    public int countPartitions(int[] nums, int k) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }

        if ((sum - k) < 0 || (sum - k) % 2 != 0) return 0;

        int target = (sum - k) / 2;
        int mod = 1000000007;
        int[] dp = new int[target + 1];
        dp[0] = 1;

        for (int num : nums) {
            for (int j = target; j >= num; j--) {
                dp[j] = (dp[j] + dp[j - num]) % mod;
            }
        }

        return dp[target];
    }
}