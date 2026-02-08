class Solution {
    private static final int MOD = 1000000007;
    private int[][] grid;
    private int[][] dp;
    private int rows, cols;

    public int countPaths(int[][] grid) {
        this.grid = grid;
        this.rows = grid.length;
        this.cols = grid[0].length;
        this.dp = new int[rows][cols];

        long totalPaths = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                totalPaths = (totalPaths + dfs(i, j)) % MOD;
            }
        }
        return (int) totalPaths;
    }

    private int dfs(int x, int y) {
        if (dp[x][y] != 0) return dp[x][y];
        dp[x][y] = 1;

        int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        for (int[] dir : directions) {
            int newX = x + dir[0], newY = y + dir[1];
            if (newX >= 0 && newX < rows && newY >= 0 && newY < cols && grid[newX][newY] > grid[x][y]) {
                dp[x][y] = (dp[x][y] + dfs(newX, newY)) % MOD;
            }
        }
        return dp[x][y];
    }
}