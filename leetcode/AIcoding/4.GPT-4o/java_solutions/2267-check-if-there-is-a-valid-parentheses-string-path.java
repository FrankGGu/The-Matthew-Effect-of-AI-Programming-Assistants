class Solution {
    public boolean hasValidPath(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        return dfs(grid, 0, 0, 0, 0, new Boolean[m][n][m + n]);
    }

    private boolean dfs(int[][] grid, int r, int c, int open, int close, Boolean[][][] memo) {
        if (r < 0 || r >= grid.length || c < 0 || c >= grid[0].length) return false;
        if (r == grid.length - 1 && c == grid[0].length - 1) return open == close;
        if (memo[r][c][open - close] != null) return memo[r][c][open - close];

        int type = grid[r][c];

        if (type == 1) {
            open++;
        } else if (type == 2) {
            close++;
        } else if (type == 3) {
            open++;
            close++;
        }

        boolean result = false;
        if (r < grid.length - 1) result |= dfs(grid, r + 1, c, open, close, memo);
        if (c < grid[0].length - 1) result |= dfs(grid, r, c + 1, open, close, memo);

        memo[r][c][open - close] = result;
        return result;
    }
}