class Solution {
    private static final int MOD = 1_000_000_007;
    private int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    private int[][] memo;
    private int m, n;

    public int countPaths(int[][] grid) {
        m = grid.length;
        n = grid[0].length;
        memo = new int[m][n];
        long result = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                result = (result + dfs(grid, i, j)) % MOD;
            }
        }
        return (int) result;
    }

    private int dfs(int[][] grid, int i, int j) {
        if (memo[i][j] != 0) {
            return memo[i][j];
        }
        int res = 1;
        for (int[] dir : directions) {
            int x = i + dir[0];
            int y = j + dir[1];
            if (x >= 0 && x < m && y >= 0 && y < n && grid[x][y] > grid[i][j]) {
                res = (res + dfs(grid, x, y)) % MOD;
            }
        }
        memo[i][j] = res;
        return res;
    }
}