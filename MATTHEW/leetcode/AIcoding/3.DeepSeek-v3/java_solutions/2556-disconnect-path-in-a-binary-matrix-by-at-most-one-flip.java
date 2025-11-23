class Solution {
    public boolean isPossibleToCutPath(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        if (!dfs(grid, 0, 0, m, n)) {
            return true;
        }

        grid[0][0] = 1;
        return !dfs(grid, 0, 0, m, n);
    }

    private boolean dfs(int[][] grid, int i, int j, int m, int n) {
        if (i == m - 1 && j == n - 1) {
            return true;
        }
        if (i >= m || j >= n || grid[i][j] == 0) {
            return false;
        }
        grid[i][j] = 0;
        return dfs(grid, i + 1, j, m, n) || dfs(grid, i, j + 1, m, n);
    }
}