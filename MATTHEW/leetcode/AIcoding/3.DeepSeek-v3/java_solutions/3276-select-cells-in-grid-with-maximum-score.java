class Solution {
    public int maxScore(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[m][n];
        dp[m-1][n-1] = grid[m-1][n-1];
        int maxScore = Integer.MIN_VALUE;

        for (int i = m-1; i >= 0; i--) {
            for (int j = n-1; j >= 0; j--) {
                if (i == m-1 && j == n-1) continue;
                int right = (j < n-1) ? dp[i][j+1] : Integer.MIN_VALUE;
                int down = (i < m-1) ? dp[i+1][j] : Integer.MIN_VALUE;
                dp[i][j] = grid[i][j] + Math.max(right, down);
                maxScore = Math.max(maxScore, dp[i][j] - grid[i][j]);
            }
        }

        return maxScore;
    }
}