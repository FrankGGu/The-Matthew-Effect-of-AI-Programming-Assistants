class Solution {
    private static final int MOD = 1_000_000_007;
    private int[][] dp;
    private int[][] grid;
    private int m;
    private int n;
    private int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public int countPaths(int[][] grid) {
        this.grid = grid;
        this.m = grid.length;
        this.n = grid[0].length;
        this.dp = new int[m][n];

        int paths = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                paths = (paths + dfs(i, j)) % MOD;
            }
        }
        return paths;
    }

    private int dfs(int i, int j) {
        if (dp[i][j] != 0) {
            return dp[i][j];
        }

        int paths = 1;
        for (int[] dir : directions) {
            int newRow = i + dir[0];
            int newCol = j + dir[1];

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && grid[newRow][newCol] > grid[i][j]) {
                paths = (paths + dfs(newRow, newCol)) % MOD;
            }
        }
        dp[i][j] = paths;
        return paths;
    }
}