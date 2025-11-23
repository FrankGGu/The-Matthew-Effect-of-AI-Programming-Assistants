class Solution {
    public int kInversePairs(int n, int k) {
        final int MOD = 1_000_000_007;

        int[] dp = new int[k + 1];

        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            int[] newDp = new int[k + 1];
            newDp[0] = 1;

            for (int j = 1; j <= k; j++) {
                newDp[j] = (newDp[j - 1] + dp[j]) % MOD;

                if (j >= i) {
                    newDp[j] = (newDp[j] - dp[j - i] + MOD) % MOD;
                }
            }
            dp = newDp;
        }

        return dp[k];
    }
}