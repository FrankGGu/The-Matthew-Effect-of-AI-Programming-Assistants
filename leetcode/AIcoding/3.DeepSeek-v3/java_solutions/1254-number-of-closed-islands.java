class Solution {
    public int closedIsland(int[][] grid) {
        if (grid == null || grid.length == 0) {
            return 0;
        }
        int rows = grid.length;
        int cols = grid[0].length;
        int count = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 0) {
                    if (dfs(grid, i, j, rows, cols)) {
                        count++;
                    }
                }
            }
        }
        return count;
    }

    private boolean dfs(int[][] grid, int i, int j, int rows, int cols) {
        if (i < 0 || i >= rows || j < 0 || j >= cols) {
            return false;
        }
        if (grid[i][j] == 1) {
            return true;
        }
        grid[i][j] = 1;
        boolean up = dfs(grid, i - 1, j, rows, cols);
        boolean down = dfs(grid, i + 1, j, rows, cols);
        boolean left = dfs(grid, i, j - 1, rows, cols);
        boolean right = dfs(grid, i, j + 1, rows, cols);
        return up && down && left && right;
    }
}