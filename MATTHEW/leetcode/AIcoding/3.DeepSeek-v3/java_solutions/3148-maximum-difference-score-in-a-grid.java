class Solution {
    public int maxScore(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[m][n];
        int maxScore = Integer.MIN_VALUE;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i == 0 && j == 0) {
                    dp[i][j] = Integer.MAX_VALUE;
                    continue;
                }
                int min = Integer.MAX_VALUE;
                if (i > 0) {
                    min = Math.min(min, dp[i - 1][j]);
                }
                if (j > 0) {
                    min = Math.min(min, dp[i][j - 1]);
                }
                dp[i][j] = Math.min(min, grid[i][j]);
                maxScore = Math.max(maxScore, grid[i][j] - min);
            }
        }

        return maxScore;
    }
}