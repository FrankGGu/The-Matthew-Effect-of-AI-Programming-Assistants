class Solution {
    private int m, n;
    private int[][] grid;
    private int[][] dp;

    public int maxPoints(int[][] grid) {
        this.grid = grid;
        this.m = grid.length;
        this.n = grid[0].length;
        this.dp = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j] = -1;
            }
        }

        return solve(0, 0);
    }

    private int solve(int row, int col) {
        if (row == m - 1) {
            return grid[row][col];
        }

        if (dp[row][col] != -1) {
            return dp[row][col];
        }

        int maxScore = 0;
        maxScore = Math.max(maxScore, grid[row][col] + solve(row + 1, col));

        if (col > 0) {
            maxScore = Math.max(maxScore, grid[row][col] + solve(row + 1, col - 1));
        }

        if (col < n - 1) {
            maxScore = Math.max(maxScore, grid[row][col] + solve(row + 1, col + 1));
        }

        return dp[row][col] = maxScore;
    }
}