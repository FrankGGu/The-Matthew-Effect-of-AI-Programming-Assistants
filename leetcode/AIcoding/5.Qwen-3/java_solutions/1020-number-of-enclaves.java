public class Solution {
    int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int numEnclaves(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        for (int i = 0; i < m; i++) {
            if (grid[i][0] == 1) dfs(grid, i, 0);
            if (grid[i][n - 1] == 1) dfs(grid, i, n - 1);
        }

        for (int j = 0; j < n; j++) {
            if (grid[0][j] == 1) dfs(grid, 0, j);
            if (grid[m - 1][j] == 1) dfs(grid, m - 1, j);
        }

        int count = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) count++;
            }
        }

        return count;
    }

    private void dfs(int[][] grid, int i, int j) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] != 1) {
            return;
        }

        grid[i][j] = 0;

        for (int[] dir : directions) {
            dfs(grid, i + dir[0], j + dir[1]);
        }
    }
}