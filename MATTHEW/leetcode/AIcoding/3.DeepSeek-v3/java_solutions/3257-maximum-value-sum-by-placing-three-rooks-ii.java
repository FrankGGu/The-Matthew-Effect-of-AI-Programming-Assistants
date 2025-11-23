class Solution {
    public long maxValueSum(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        long[][] dp1 = new long[m][n];
        long[][] dp2 = new long[m][n];
        long[][] dp3 = new long[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dp1[i][j] = grid[i][j];
                if (i > 0) dp1[i][j] = Math.max(dp1[i][j], dp1[i - 1][j]);
                if (j > 0) dp1[i][j] = Math.max(dp1[i][j], dp1[i][j - 1]);
            }
        }

        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                dp2[i][j] = grid[i][j];
                if (i < m - 1) dp2[i][j] = Math.max(dp2[i][j], dp2[i + 1][j]);
                if (j < n - 1) dp2[i][j] = Math.max(dp2[i][j], dp2[i][j + 1]);
            }
        }

        long max = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dp3[i][j] = grid[i][j];
                if (i > 0 && j > 0) dp3[i][j] = Math.max(dp3[i][j], dp1[i - 1][j - 1] + grid[i][j]);
                if (i < m - 1 && j < n - 1) dp3[i][j] = Math.max(dp3[i][j], dp2[i + 1][j + 1] + grid[i][j]);
                if (i > 0 && j < n - 1) dp3[i][j] = Math.max(dp3[i][j], dp1[i - 1][j + 1] + grid[i][j]);
                if (i < m - 1 && j > 0) dp3[i][j] = Math.max(dp3[i][j], dp2[i + 1][j - 1] + grid[i][j]);
                max = Math.max(max, dp3[i][j]);
            }
        }

        return max;
    }
}