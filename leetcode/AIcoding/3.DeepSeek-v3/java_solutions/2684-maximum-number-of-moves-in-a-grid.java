class Solution {
    public int maxMoves(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[m][n];
        int maxMoves = 0;

        for (int j = n - 2; j >= 0; j--) {
            for (int i = 0; i < m; i++) {
                int current = grid[i][j];
                int maxNext = 0;

                if (i > 0 && grid[i - 1][j + 1] > current) {
                    maxNext = Math.max(maxNext, dp[i - 1][j + 1] + 1);
                }
                if (grid[i][j + 1] > current) {
                    maxNext = Math.max(maxNext, dp[i][j + 1] + 1);
                }
                if (i < m - 1 && grid[i + 1][j + 1] > current) {
                    maxNext = Math.max(maxNext, dp[i + 1][j + 1] + 1);
                }

                dp[i][j] = maxNext;
                if (j == 0) {
                    maxMoves = Math.max(maxMoves, dp[i][j]);
                }
            }
        }

        return maxMoves;
    }
}