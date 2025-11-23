class Solution {
    public int findBall(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        for (int j = 0; j < n; j++) {
            if (dfs(0, j, grid)) {
                return j;
            }
        }
        return -1;
    }

    private boolean dfs(int i, int j, int[][] grid) {
        if (i == grid.length) {
            return true;
        }
        if (grid[i][j] == 1) {
            if (j == grid[0].length - 1 || grid[i][j + 1] == -1) {
                return false;
            }
            return dfs(i + 1, j + 1, grid);
        } else {
            if (j == 0 || grid[i][j - 1] == 1) {
                return false;
            }
            return dfs(i + 1, j - 1, grid);
        }
    }
}