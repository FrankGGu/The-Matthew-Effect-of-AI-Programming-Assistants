class Solution {
    public int longestSpecialPath(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dp = new int[m][n];
        int maxPath = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                maxPath = Math.max(maxPath, dfs(grid, dp, i, j, Integer.MIN_VALUE));
            }
        }

        return maxPath;
    }

    private int dfs(int[][] grid, int[][] dp, int i, int j, int prev) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] <= prev) {
            return 0;
        }

        if (dp[i][j] != 0) {
            return dp[i][j];
        }

        int current = grid[i][j];
        int down = dfs(grid, dp, i + 1, j, current);
        int up = dfs(grid, dp, i - 1, j, current);
        int right = dfs(grid, dp, i, j + 1, current);
        int left = dfs(grid, dp, i, j - 1, current);

        dp[i][j] = 1 + Math.max(Math.max(down, up), Math.max(right, left));
        return dp[i][j];
    }
}