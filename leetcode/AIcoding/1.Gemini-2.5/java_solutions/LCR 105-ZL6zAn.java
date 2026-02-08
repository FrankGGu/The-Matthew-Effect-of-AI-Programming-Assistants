class Solution {
    public int maxAreaOfIsland(int[][] grid) {
        int maxArea = 0;
        int m = grid.length;
        int n = grid[0].length;

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (grid[r][c] == 1) {
                    maxArea = Math.max(maxArea, dfs(grid, r, c, m, n));
                }
            }
        }
        return maxArea;
    }

    private int dfs(int[][] grid, int r, int c, int m, int n) {
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0) {
            return 0;
        }

        grid[r][c] = 0; // Mark as visited
        int currentArea = 1;

        currentArea += dfs(grid, r + 1, c, m, n);
        currentArea += dfs(grid, r - 1, c, m, n);
        currentArea += dfs(grid, r, c + 1, m, n);
        currentArea += dfs(grid, r, c - 1, m, n);

        return currentArea;
    }
}