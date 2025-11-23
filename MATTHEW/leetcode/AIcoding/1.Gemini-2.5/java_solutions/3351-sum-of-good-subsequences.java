class Solution {
    public int sumOfGoodSubsequences(int[] nums, int k) {
        int MOD = 1_000_000_007;

        int[] dp = new int[k];
        dp[0] = 1;

        for (int num : nums) {
            int[] nextDp = new int[k];

            for (int j = 0; j < k; j++) {
                nextDp[j] = (nextDp[j] + dp[j]) % MOD;

                int newRemainder = (j + (num % k) + k) % k;
                nextDp[newRemainder] = (nextDp[newRemainder] + dp[j]) % MOD;
            }
            dp = nextDp;
        }

        return dp[0];
    }
}