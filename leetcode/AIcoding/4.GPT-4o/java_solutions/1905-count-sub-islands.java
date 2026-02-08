class Solution {
    public int countSubIslands(int[][] grid1, int[][] grid2) {
        int count = 0;
        int m = grid1.length, n = grid1[0].length;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid2[i][j] == 1 && grid1[i][j] == 0) {
                    dfs(grid2, i, j);
                }
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid2[i][j] == 1) {
                    if (isSubIsland(grid1, grid2, i, j)) {
                        count++;
                    }
                }
            }
        }

        return count;
    }

    private void dfs(int[][] grid, int i, int j) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] == 0) {
            return;
        }
        grid[i][j] = 0;
        dfs(grid, i + 1, j);
        dfs(grid, i - 1, j);
        dfs(grid, i, j + 1);
        dfs(grid, i, j - 1);
    }

    private boolean isSubIsland(int[][] grid1, int[][] grid2, int i, int j) {
        if (i < 0 || i >= grid1.length || j < 0 || j >= grid1[0].length) {
            return true;
        }
        if (grid2[i][j] == 0) {
            return true;
        }
        return grid1[i][j] == 1 && isSubIsland(grid1, grid2, i + 1, j) && isSubIsland(grid1, grid2, i - 1, j) && 
               isSubIsland(grid1, grid2, i, j + 1) && isSubIsland(grid1, grid2, i, j - 1);
    }
}