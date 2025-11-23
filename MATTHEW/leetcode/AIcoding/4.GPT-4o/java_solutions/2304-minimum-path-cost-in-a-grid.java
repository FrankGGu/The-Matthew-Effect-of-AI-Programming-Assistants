import java.util.*;

class Solution {
    public int minPathCost(int[][] grid, int[][] moveCost) {
        int m = grid.length, n = grid[0].length;
        int[][] dp = new int[m][n];

        for (int j = 0; j < n; j++) {
            dp[0][j] = grid[0][j];
        }

        for (int i = 1; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = 0; k < n; k++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][k] + grid[i][j] + moveCost[k][j]);
                }
            }
        }

        int minCost = Integer.MAX_VALUE;
        for (int j = 0; j < n; j++) {
            minCost = Math.min(minCost, dp[m - 1][j]);
        }

        return minCost;
    }
}