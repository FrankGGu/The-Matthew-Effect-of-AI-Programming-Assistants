class Solution {
    private int uniquePaths = 0;
    private int startX, startY, endX, endY, emptyCount;

    public int uniquePathsIII(int[][] grid) {
        int rows = grid.length, cols = grid[0].length;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    startX = i;
                    startY = j;
                } else if (grid[i][j] == 2) {
                    endX = i;
                    endY = j;
                } else if (grid[i][j] == 0) {
                    emptyCount++;
                }
            }
        }
        dfs(grid, startX, startY, emptyCount);
        return uniquePaths;
    }

    private void dfs(int[][] grid, int x, int y, int remainingEmpty) {
        if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length || grid[x][y] == -1) {
            return;
        }
        if (x == endX && y == endY) {
            if (remainingEmpty == -1) {
                uniquePaths++;
            }
            return;
        }
        grid[x][y] = -1; // mark as visited
        dfs(grid, x + 1, y, remainingEmpty - 1);
        dfs(grid, x - 1, y, remainingEmpty - 1);
        dfs(grid, x, y + 1, remainingEmpty - 1);
        dfs(grid, x, y - 1, remainingEmpty - 1);
        grid[x][y] = 0; // unmark for backtracking
    }
}