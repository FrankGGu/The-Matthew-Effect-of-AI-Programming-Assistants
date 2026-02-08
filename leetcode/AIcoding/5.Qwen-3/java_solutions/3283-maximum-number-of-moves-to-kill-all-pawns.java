public class Solution {
    public int maxMoves(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[m][n];
        int maxMoves = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    int max = 0;
                    if (i > 0 && grid[i - 1][j] == 0) max = Math.max(max, dp[i - 1][j]);
                    if (i < m - 1 && grid[i + 1][j] == 0) max = Math.max(max, dp[i + 1][j]);
                    if (j > 0 && grid[i][j - 1] == 0) max = Math.max(max, dp[i][j - 1]);
                    if (j < n - 1 && grid[i][j + 1] == 0) max = Math.max(max, dp[i][j + 1]);
                    dp[i][j] = max + 1;
                    maxMoves = Math.max(maxMoves, dp[i][j]);
                }
            }
        }

        return maxMoves;
    }
}