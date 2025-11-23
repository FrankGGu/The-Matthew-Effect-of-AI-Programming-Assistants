public class Solution {
    public boolean isGridCut(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    return dfs(grid, i, j, rows, cols);
                }
            }
        }
        return false;
    }

    private boolean dfs(int[][] grid, int i, int j, int rows, int cols) {
        if (i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] != 1) {
            return false;
        }

        grid[i][j] = 0;

        boolean up = dfs(grid, i - 1, j, rows, cols);
        boolean down = dfs(grid, i + 1, j, rows, cols);
        boolean left = dfs(grid, i, j - 1, rows, cols);
        boolean right = dfs(grid, i, j + 1, rows, cols);

        return up || down || left || right;
    }
}