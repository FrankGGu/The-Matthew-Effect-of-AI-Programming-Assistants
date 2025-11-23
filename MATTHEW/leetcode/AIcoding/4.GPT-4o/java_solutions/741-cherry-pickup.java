class Solution {
    public int cherryPickup(int[][] grid) {
        int n = grid.length;
        int[][][] dp = new int[n][n][n];
        for (int[][] layer : dp) {
            for (int[] row : layer) {
                Arrays.fill(row, -1);
            }
        }
        return Math.max(0, dfs(grid, 0, 0, 0, dp));
    }

    private int dfs(int[][] grid, int r1, int c1, int r2, int[][][] dp) {
        int n = grid.length;
        int c2 = r1 + c1 - r2;
        if (r1 >= n || c1 >= n || r2 >= n || c2 >= n || grid[r1][c1] == -1 || grid[r2][c2] == -1) {
            return Integer.MIN_VALUE;
        }
        if (r1 == n - 1 && c1 == n - 1) {
            return grid[r1][c1];
        }
        if (dp[r1][c1][r2] != -1) {
            return dp[r1][c1][r2];
        }
        int cherries = grid[r1][c1];
        if (r1 != r2) cherries += grid[r2][c2];
        int maxCherries = 0;
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                maxCherries = Math.max(maxCherries, dfs(grid, r1 + i, c1 + 1, r2 + j, dp));
            }
        }
        dp[r1][c1][r2] = cherries + maxCherries;
        return dp[r1][c1][r2];
    }
}