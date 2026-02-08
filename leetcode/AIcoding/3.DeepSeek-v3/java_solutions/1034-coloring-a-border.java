class Solution {
    public int[][] colorBorder(int[][] grid, int row, int col, int color) {
        int m = grid.length, n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        int originalColor = grid[row][col];
        dfs(grid, row, col, originalColor, color, visited);
        return grid;
    }

    private void dfs(int[][] grid, int x, int y, int originalColor, int newColor, boolean[][] visited) {
        if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length || grid[x][y] != originalColor || visited[x][y]) {
            return;
        }
        visited[x][y] = true;
        boolean isBorder = false;
        if (x == 0 || x == grid.length - 1 || y == 0 || y == grid[0].length - 1) {
            isBorder = true;
        } else {
            int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
            for (int[] dir : dirs) {
                int nx = x + dir[0], ny = y + dir[1];
                if (!visited[nx][ny] && grid[nx][ny] != originalColor) {
                    isBorder = true;
                    break;
                }
            }
        }
        if (isBorder) {
            grid[x][y] = newColor;
        }
        dfs(grid, x + 1, y, originalColor, newColor, visited);
        dfs(grid, x - 1, y, originalColor, newColor, visited);
        dfs(grid, x, y + 1, originalColor, newColor, visited);
        dfs(grid, x, y - 1, originalColor, newColor, visited);
    }
}