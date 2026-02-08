public class Solution {
    public int maxMoves(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[m][n];
        int maxMove = 0;

        for (int j = n - 1; j >= 0; j--) {
            for (int i = 0; i < m; i++) {
                if (j == n - 1) {
                    dp[i][j] = 0;
                } else {
                    int max = -1;
                    if (i > 0 && grid[i - 1][j + 1] > grid[i][j]) {
                        max = Math.max(max, dp[i - 1][j + 1]);
                    }
                    if (grid[i][j + 1] > grid[i][j]) {
                        max = Math.max(max, dp[i][j + 1]);
                    }
                    if (i < m - 1 && grid[i + 1][j + 1] > grid[i][j]) {
                        max = Math.max(max, dp[i + 1][j + 1]);
                    }
                    dp[i][j] = max + 1;
                }
                maxMove = Math.max(maxMove, dp[i][j]);
            }
        }

        return maxMove;
    }
}