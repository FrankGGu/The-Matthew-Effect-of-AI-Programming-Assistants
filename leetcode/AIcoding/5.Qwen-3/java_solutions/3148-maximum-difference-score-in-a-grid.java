public class Solution {

import java.util.*;

public class Solution {
    public int maxDiffScore(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int[][] dp = new int[rows][cols];

        for (int i = 0; i < rows; i++) {
            Arrays.fill(dp[i], Integer.MIN_VALUE);
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (i == 0 && j == 0) {
                    dp[i][j] = grid[i][j];
                } else {
                    int maxPrev = Integer.MIN_VALUE;
                    if (i > 0) maxPrev = Math.max(maxPrev, dp[i - 1][j]);
                    if (j > 0) maxPrev = Math.max(maxPrev, dp[i][j - 1]);
                    if (i > 0 && j > 0) maxPrev = Math.max(maxPrev, dp[i - 1][j - 1]);
                    dp[i][j] = maxPrev + grid[i][j];
                }
            }
        }

        int maxScore = Integer.MIN_VALUE;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                maxScore = Math.max(maxScore, dp[i][j]);
            }
        }

        return maxScore;
    }
}
}