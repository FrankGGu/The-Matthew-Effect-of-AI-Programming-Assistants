public class Solution {

import java.util.*;

public class Solution {
    public int countPyramids(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int[][] dp = new int[rows][cols];
        int total = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    dp[i][j] = 1;
                    if (i > 0 && j > 0 && j < cols - 1) {
                        dp[i][j] = Math.min(dp[i - 1][j - 1], Math.min(dp[i - 1][j], dp[i - 1][j + 1])) + 1;
                    }
                }
            }
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (dp[i][j] >= 2) {
                    total += dp[i][j] - 1;
                }
            }
        }

        return total;
    }
}
}