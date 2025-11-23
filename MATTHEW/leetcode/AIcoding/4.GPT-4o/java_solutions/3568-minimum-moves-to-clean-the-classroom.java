class Solution {
    public int minimumMoves(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        int[][] dp = new int[n][m];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (dp[i][j] == Integer.MAX_VALUE) continue;
                for (int x = i; x < n; x++) {
                    for (int y = j; y < m; y++) {
                        if (grid[x][y] == 1) continue;
                        if (x - i + 1 + y - j + 1 <= 3) {
                            dp[x][y] = Math.min(dp[x][y], dp[i][j] + 1);
                        }
                    }
                }
            }
        }
        return dp[n - 1][m - 1] == Integer.MAX_VALUE ? -1 : dp[n - 1][m - 1];
    }
}