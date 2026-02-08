import java.util.Arrays;

public class Solution {
    public int minCost(int[][] costs, int m, int n, int target) {
        int[][] dp = new int[m + 1][target + 1];
        for (int[] row : dp) Arrays.fill(row, Integer.MAX_VALUE);
        dp[0][0] = 0;

        for (int i = 1; i <= m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k <= target; k++) {
                    if (dp[i - 1][k] != Integer.MAX_VALUE) {
                        int newCost = dp[i - 1][k] + costs[i - 1][j];
                        if (k + (j == 0 ? 1 : 0) <= target) {
                            dp[i][k + (j == 0 ? 1 : 0)] = Math.min(dp[i][k + (j == 0 ? 1 : 0)], newCost);
                        }
                    }
                }
            }
        }

        int res = Integer.MAX_VALUE;
        for (int i = 0; i <= target; i++) {
            res = Math.min(res, dp[m][i]);
        }

        return res == Integer.MAX_VALUE ? -1 : res;
    }
}