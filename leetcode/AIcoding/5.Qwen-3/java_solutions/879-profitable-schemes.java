public class Solution {
    public int profitableSchemes(int[] group, int[] profit, int target) {
        int n = group.length;
        int[][] dp = new int[target + 1][target + 1];
        for (int i = 0; i <= target; i++) {
            dp[0][i] = 1;
        }
        for (int i = 0; i < n; i++) {
            for (int j = target; j >= 0; j--) {
                for (int k = target; k >= 0; k--) {
                    if (k + profit[i] <= target) {
                        dp[j + 1][k + profit[i]] += dp[j][k];
                    } else {
                        dp[j + 1][target] += dp[j][k];
                    }
                }
            }
        }
        return dp[target][target];
    }
}