class Solution {
    public int sumOfSubsequenceWeights(int[] nums) {
        int n = nums.length;
        long mod = 1000000007;
        long[][] dp = new long[n + 1][2];

        Arrays.sort(nums);

        for (int i = 0; i < n; i++) {
            dp[i + 1][0] = (dp[i][0] + dp[i][1]) % mod;
            dp[i + 1][1] = (dp[i][1] + (long) nums[i] * (dp[i][0] + 1)) % mod;
        }

        return (int) ((dp[n][0] + dp[n][1]) % mod);
    }
}