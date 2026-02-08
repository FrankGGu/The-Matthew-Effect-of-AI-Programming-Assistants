class Solution {
    public int countSpecialSubsequences(int[] nums) {
        int mod = 1_000_000_007;
        int n = nums.length;
        long[][] dp = new long[n + 1][4];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            int num = nums[i - 1];
            for (int j = 0; j < 4; j++) {
                dp[i][j] = dp[i - 1][j] * 2 % mod;
            }
            if (num > 0) {
                dp[i][num] = (dp[i][num] + dp[i - 1][num - 1]) % mod;
            }
        }

        return (int) (dp[n][3] - 1 + mod) % mod;
    }
}