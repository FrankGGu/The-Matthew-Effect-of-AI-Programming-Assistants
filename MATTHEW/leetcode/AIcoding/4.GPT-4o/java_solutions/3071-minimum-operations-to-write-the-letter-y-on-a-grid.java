class Solution {
    public int minimumOperations(char[][] grid) {
        int n = grid.length, m = grid[0].length;
        int[][] dp = new int[n + 1][m + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= m; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }
        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                for (int di = 0; di < n; di++) {
                    for (int dj = 0; dj < m; dj++) {
                        if (i == di && j == dj) continue;
                        int cost = 0;
                        if (grid[di][dj] != 'Y') cost++;
                        if (grid[i][j] != 'Y') cost++;
                        dp[di + 1][dj + 1] = Math.min(dp[di + 1][dj + 1], dp[i + 1][j + 1] + cost);
                    }
                }
            }
        }
        return dp[n][m];
    }
}