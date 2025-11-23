public class Solution {

import java.util.*;

public class Solution {
    public int minPathCost(int[][] grid, int[] cost) {
        int rows = grid.length;
        int cols = grid[0].length;

        int[][] dp = new int[rows][cols];
        for (int j = 0; j < cols; j++) {
            dp[0][j] = grid[0][j];
        }

        for (int i = 1; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                int minPrev = Integer.MAX_VALUE;
                for (int k = 0; k < cols; k++) {
                    minPrev = Math.min(minPrev, dp[i-1][k] + cost[Math.abs(k - j)]);
                }
                dp[i][j] = minPrev + grid[i][j];
            }
        }

        int result = Integer.MAX_VALUE;
        for (int j = 0; j < cols; j++) {
            result = Math.min(result, dp[rows-1][j]);
        }
        return result;
    }
}
}