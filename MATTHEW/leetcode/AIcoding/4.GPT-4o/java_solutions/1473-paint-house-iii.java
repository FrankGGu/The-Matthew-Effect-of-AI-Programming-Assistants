public class Solution {
    public int minCost(int[][] costs, int m, int n, int target) {
        int[][][] dp = new int[m + 1][n + 1][target + 1];
        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                for (int k = 0; k <= target; k++) {
                    dp[i][j][k] = Integer.MAX_VALUE;
                }
            }
        }
        dp[0][0][0] = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k <= target; k++) {
                    if (dp[i][j][k] == Integer.MAX_VALUE) continue;
                    for (int color = 0; color < n; color++) {
                        int newCost = dp[i][j][k] + costs[i][color];
                        int newK = k + ((j == 0 || j != color) ? 1 : 0);
                        if (newK <= target) {
                            dp[i + 1][color][newK] = Math.min(dp[i + 1][color][newK], newCost);
                        }
                    }
                }
            }
            for (int k = 0; k <= target; k++) {
                for (int color = 0; color < n; color++) {
                    dp[i + 1][color][k] = Math.min(dp[i + 1][color][k], dp[i][color][k]);
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int j = 0; j < n; j++) {
            result = Math.min(result, dp[m][j][target]);
        }
        return result == Integer.MAX_VALUE ? -1 : result;
    }
}