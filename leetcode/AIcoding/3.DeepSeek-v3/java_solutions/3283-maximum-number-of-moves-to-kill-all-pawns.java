class Solution {
    public int maxMoves(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[m][n];
        int maxMoves = 0;

        for (int j = n - 2; j >= 0; j--) {
            for (int i = 0; i < m; i++) {
                int max = 0;
                for (int k = Math.max(0, i - 1); k <= Math.min(m - 1, i + 1); k++) {
                    if (grid[k][j + 1] > grid[i][j]) {
                        max = Math.max(max, dp[k][j + 1] + 1);
                    }
                }
                dp[i][j] = max;
                if (j == 0) {
                    maxMoves = Math.max(maxMoves, dp[i][j]);
                }
            }
        }

        return maxMoves;
    }
}