class Solution {
    public int closedIsland(int[][] grid) {
        if (grid == null || grid.length == 0 || grid[0].length == 0) {
            return 0;
        }

        int m = grid.length;
        int n = grid[0].length;

        // Step 1: Mark boundary-connected land as water (1)
        // First and last rows
        for (int j = 0; j < n; j++) {
            if (grid[0][j] == 0) {
                dfs(grid, 0, j);
            }
            if (grid[m - 1][j] == 0) {
                dfs(grid, m - 1, j);
            }
        }

        // First and last columns (excluding corners already covered by row loops)
        for (int i = 0; i < m; i++) {
            if (grid[i][0] == 0) {
                dfs(grid, i, 0);
            }
            if (grid[i][n - 1] == 0) {
                dfs(grid, i, n - 1);
            }
        }

        // Step 2: Count closed islands
        int closedIslands = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 0) {
                    closedIslands++;
                    dfs(grid, i, j); // Sink the current closed island
                }
            }
        }

        return closedIslands;
    }

    private void dfs(int[][] grid, int r, int c) {
        int m = grid.length;
        int n = grid[0].length;

        // Base cases for DFS
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 1) {
            return;
        }

        // Mark current cell as visited/water
        grid[r][c] = 1;

        // Explore neighbors
        dfs(grid, r + 1, c);
        dfs(grid, r - 1, c);
        dfs(grid, r, c + 1);
        dfs(grid, r, c - 1);
    }
}