class Solution {
    public int waysToReachTarget(int target, int[][] types) {
        int MOD = 1000000007;
        int[] dp = new int[target + 1];
        dp[0] = 1;

        for (int[] type : types) {
            int count = type[0];
            int mark = type[1];
            for (int i = target; i >= 0; --i) {
                for (int k = 1; k <= count; ++k) {
                    if (i - k * mark >= 0) {
                        dp[i] = (dp[i] + dp[i - k * mark]) % MOD;
                    }
                }
            }
        }

        return dp[target];
    }
}