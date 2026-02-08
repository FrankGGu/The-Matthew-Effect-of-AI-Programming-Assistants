class Solution {
    public int maxValue(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dp = new int[m][n];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MIN_VALUE);
        }
        dp[0][0] = grid[0][0];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i > 0) dp[i][j] = Math.max(dp[i][j], dp[i - 1][j] + grid[i][j]);
                if (j > 0) dp[i][j] = Math.max(dp[i][j], dp[i][j - 1] + grid[i][j]);
            }
        }

        int max = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int temp = dp[i][j];
                int sum = grid[i][j];
                if (i > 0) sum += dp[i - 1][j];
                if (j > 0) sum += dp[i][j - 1];
                max = Math.max(max, sum);
            }
        }
        return max;
    }
}