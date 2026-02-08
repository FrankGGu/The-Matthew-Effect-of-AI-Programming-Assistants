public class Solution {
    public int cherryPickup(int[][] grid) {
        int n = grid.length;
        int[][][] dp = new int[n][n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    dp[i][j][k] = -1;
                }
            }
        }
        return Math.max(0, dfs(grid, 0, 0, 0, dp));
    }

    private int dfs(int[][] grid, int x1, int y1, int x2, int[][][] dp) {
        int n = grid.length;
        int y2 = x1 + y1 - x2;
        if (x1 >= n || y1 >= n || x2 >= n || y2 >= n) {
            return -1;
        }
        if (x1 == n - 1 && y1 == n - 1) {
            return grid[x1][y1];
        }
        if (dp[x1][y1][x2] != -1) {
            return dp[x1][y1][x2];
        }
        int maxCherries = -1;
        int[][] directions = {{0, 0}, {0, 1}, {1, 0}, {1, 1}};
        for (int[] d1 : directions) {
            for (int[] d2 : directions) {
                int nx1 = x1 + d1[0];
                int ny1 = y1 + d1[1];
                int nx2 = x2 + d2[0];
                int ny2 = y2 + d2[1];
                int res = dfs(grid, nx1, ny1, nx2, dp);
                if (res != -1) {
                    if (x1 == x2 && y1 == y2) {
                        maxCherries = Math.max(maxCherries, res + grid[x1][y1]);
                    } else {
                        maxCherries = Math.max(maxCherries, res + grid[x1][y1] + grid[x2][y2]);
                    }
                }
            }
        }
        dp[x1][y1][x2] = maxCherries;
        return maxCherries;
    }
}