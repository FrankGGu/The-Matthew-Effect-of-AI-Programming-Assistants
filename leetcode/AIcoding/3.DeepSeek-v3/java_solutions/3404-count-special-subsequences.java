class Solution {
    public int countSpecialSubsequences(int[] nums) {
        int MOD = 1000000007;
        long[] dp = new long[3];

        for (int num : nums) {
            if (num == 0) {
                dp[0] = (dp[0] * 2 + 1) % MOD;
            } else if (num == 1) {
                dp[1] = (dp[1] * 2 + dp[0]) % MOD;
            } else if (num == 2) {
                dp[2] = (dp[2] * 2 + dp[1]) % MOD;
            }
        }

        return (int) dp[2];
    }
}