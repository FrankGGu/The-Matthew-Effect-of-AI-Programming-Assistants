public class Solution {
    public int numRollsToTarget(int d, int f, int target) {
        int MOD = 1000000007;
        int[][] dp = new int[d + 1][target + 1];
        dp[0][0] = 1;
        for (int i = 1; i <= d; i++) {
            for (int j = 1; j <= target; j++) {
                for (int k = 1; k <= f && j - k >= 0; k++) {
                    dp[i][j] += dp[i - 1][j - k];
                    dp[i][j] %= MOD;
                }
            }
        }
        return dp[d][target];
    }
}