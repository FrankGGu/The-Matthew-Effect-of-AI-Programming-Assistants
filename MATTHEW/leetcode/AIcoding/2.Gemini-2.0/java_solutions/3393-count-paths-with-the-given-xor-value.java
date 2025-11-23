class Solution {
    public int countPaths(int[][] grid, int x) {
        int m = grid.length;
        int n = grid[0].length;
        return dfs(grid, 0, 0, 0, x);
    }

    private int dfs(int[][] grid, int row, int col, int currentXor, int targetXor) {
        if (row >= grid.length || col >= grid[0].length) {
            return 0;
        }

        currentXor ^= grid[row][col];

        if (row == grid.length - 1 && col == grid[0].length - 1) {
            return currentXor == targetXor ? 1 : 0;
        }

        return dfs(grid, row + 1, col, currentXor, targetXor) +
               dfs(grid, row, col + 1, currentXor, targetXor);
    }
}