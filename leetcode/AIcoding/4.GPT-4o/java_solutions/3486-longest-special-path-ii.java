class Solution {
    public int longestSpecialPath(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dp = new int[m][n];
        int maxLength = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                maxLength = Math.max(maxLength, dfs(grid, dp, i, j));
            }
        }
        return maxLength;
    }

    private int dfs(int[][] grid, int[][] dp, int x, int y) {
        if (dp[x][y] != 0) return dp[x][y];

        int m = grid.length, n = grid[0].length;
        int max = 1;

        int[] dx = {0, 1, 0, -1};
        int[] dy = {1, 0, -1, 0};

        for (int k = 0; k < 4; k++) {
            int nx = x + dx[k], ny = y + dy[k];
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] > grid[x][y]) {
                max = Math.max(max, 1 + dfs(grid, dp, nx, ny));
            }
        }
        dp[x][y] = max;
        return max;
    }
}