public class Solution {

import java.util.*;

public class Solution {
    int[][] dp;
    int rows;
    int cols;
    int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int countPaths(int[][] grid) {
        rows = grid.length;
        cols = grid[0].length;
        dp = new int[rows][cols];
        for (int[] row : dp) {
            Arrays.fill(row, -1);
        }

        int result = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                result += dfs(grid, i, j);
            }
        }
        return result;
    }

    private int dfs(int[][] grid, int i, int j) {
        if (dp[i][j] != -1) {
            return dp[i][j];
        }

        int count = 1;
        for (int[] dir : directions) {
            int ni = i + dir[0];
            int nj = j + dir[1];
            if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && grid[ni][nj] > grid[i][j]) {
                count += dfs(grid, ni, nj);
            }
        }

        dp[i][j] = count;
        return count;
    }
}
}