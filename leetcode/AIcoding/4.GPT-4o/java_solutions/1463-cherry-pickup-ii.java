class Solution {
    public int cherryPickup(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][][] dp = new int[m][n][n];

        for (int i = 0; i < m; i++) {
            for (int j1 = 0; j1 < n; j1++) {
                for (int j2 = 0; j2 < n; j2++) {
                    dp[i][j1][j2] = -1;
                }
            }
        }

        return Math.max(0, dfs(grid, 0, 0, n - 1, dp));
    }

    private int dfs(int[][] grid, int row, int col1, int col2, int[][][] dp) {
        int m = grid.length, n = grid[0].length;
        if (col1 < 0 || col1 >= n || col2 < 0 || col2 >= n) return 0;
        if (row == m) return 0;
        if (dp[row][col1][col2] != -1) return dp[row][col1][col2];

        int cherries = grid[row][col1];
        if (col1 != col2) cherries += grid[row][col2];

        int maxCherries = 0;
        for (int newCol1 = col1 - 1; newCol1 <= col1 + 1; newCol1++) {
            for (int newCol2 = col2 - 1; newCol2 <= col2 + 1; newCol2++) {
                maxCherries = Math.max(maxCherries, dfs(grid, row + 1, newCol1, newCol2, dp));
            }
        }

        dp[row][col1][col2] = cherries + maxCherries;
        return dp[row][col1][col2];
    }
}