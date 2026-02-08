class Solution {
    private int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
    private int rows, cols;
    private boolean[][] visited;

    public boolean containsCycle(char[][] grid) {
        rows = grid.length;
        cols = grid[0].length;
        visited = new boolean[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (!visited[i][j]) {
                    if (dfs(grid, i, j, -1, -1, grid[i][j])) {
                        return true;
                    }
                }
            }
        }

        return false;
    }

    private boolean dfs(char[][] grid, int row, int col, int parentRow, int parentCol, char target) {
        visited[row][col] = true;

        for (int[] dir : directions) {
            int newRow = row + dir[0];
            int newCol = col + dir[1];

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] == target) {
                if (!visited[newRow][newCol]) {
                    if (dfs(grid, newRow, newCol, row, col, target)) {
                        return true;
                    }
                } else if (newRow != parentRow || newCol != parentCol) {
                    return true;
                }
            }
        }

        return false;
    }
}