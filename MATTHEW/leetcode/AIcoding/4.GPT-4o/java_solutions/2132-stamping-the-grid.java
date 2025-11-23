class Solution {
    public boolean canStamp(int[][] grid, int[][] stamp) {
        int m = grid.length, n = grid[0].length;
        int stampRows = stamp.length, stampCols = stamp[0].length;

        boolean[][] visited = new boolean[m][n];

        for (int i = 0; i <= m - stampRows; i++) {
            for (int j = 0; j <= n - stampCols; j++) {
                if (canPlace(grid, stamp, visited, i, j)) {
                    markVisited(visited, i, j, stampRows, stampCols);
                }
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (!visited[i][j] && grid[i][j] > 0) {
                    return false;
                }
            }
        }

        return true;
    }

    private boolean canPlace(int[][] grid, int[][] stamp, boolean[][] visited, int row, int col) {
        for (int i = 0; i < stamp.length; i++) {
            for (int j = 0; j < stamp[0].length; j++) {
                if (stamp[i][j] == 1 && (visited[row + i][col + j] || grid[row + i][col + j] == 0)) {
                    return false;
                }
            }
        }
        return true;
    }

    private void markVisited(boolean[][] visited, int row, int col, int stampRows, int stampCols) {
        for (int i = 0; i < stampRows; i++) {
            for (int j = 0; j < stampCols; j++) {
                visited[row + i][col + j] = true;
            }
        }
    }
}