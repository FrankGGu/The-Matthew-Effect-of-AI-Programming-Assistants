class Solution {
    public int[][] colorBorder(int[][] grid, int row, int col, int color) {
        int m = grid.length;
        int n = grid[0].length;
        int originalColor = grid[row][col];
        boolean[][] visited = new boolean[m][n];

        dfs(grid, row, col, originalColor, color, visited);

        return grid;
    }

    private void dfs(int[][] grid, int row, int col, int originalColor, int color, boolean[][] visited) {
        int m = grid.length;
        int n = grid[0].length;

        if (row < 0 || row >= m || col < 0 || col >= n || visited[row][col] || grid[row][col] != originalColor) {
            return;
        }

        visited[row][col] = true;

        boolean isBorder = row == 0 || row == m - 1 || col == 0 || col == n - 1;
        if (!isBorder) {
            if (grid[row - 1][col] != originalColor || grid[row + 1][col] != originalColor ||
                grid[row][col - 1] != originalColor || grid[row][col + 1] != originalColor) {
                isBorder = true;
            }
        }

        dfs(grid, row + 1, col, originalColor, color, visited);
        dfs(grid, row - 1, col, originalColor, color, visited);
        dfs(grid, row, col + 1, originalColor, color, visited);
        dfs(grid, row, col - 1, originalColor, color, visited);

        if (isBorder) {
            grid[row][col] = color;
        }
    }
}