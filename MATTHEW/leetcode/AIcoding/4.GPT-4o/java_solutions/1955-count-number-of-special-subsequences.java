class Solution {
    public int countSpecialSubsequences(int[] nums) {
        int n = nums.length;
        int mod = 1000000007;
        long[][] dp = new long[n + 1][4];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            int num = nums[i - 1];
            for (int j = 0; j < 4; j++) {
                dp[i][j] = dp[i - 1][j];
            }
            if (num > 0) {
                dp[i][num] = (dp[i][num] + dp[i - 1][num - 1]) % mod;
            }
            if (num == 0) {
                dp[i][0] = (dp[i][0] + dp[i - 1][0]) % mod;
            }
        }

        return (int) (dp[n][3] - 1 + mod) % mod;
    }
}