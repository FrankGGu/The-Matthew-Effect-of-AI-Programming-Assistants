class Solution {
    public int maxScore(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // dp[i][j] stores the minimum value of (grid[x][y] - x - y)
        // for all 0 <= x <= i and 0 <= y <= j.
        int[][] dp = new int[m][n];

        // maxScore stores the maximum (grid[r2][c2] - r2 - c2) - (grid[r1][c1] - r1 - c1) found so far.
        // Initialize with Integer.MIN_VALUE, as scores can be negative.
        // The problem implies that (r1,c1) and (r2,c2) can be the same, yielding a score of 0.
        // We will take Math.max(0, maxScore) at the end to account for this.
        int maxScore = Integer.MIN_VALUE; 

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                // Calculate the value for the current cell (r2, c2)
                int currentVal = grid[i][j] - i - j;

                // Find the minimum (grid[r1][c1] - r1 - c1) from cells (r1, c1)
                // such that r1 <= i and c1 <= j, but (r1, c1) is not (i, j).
                // This minimum can come from the cell directly above (i-1, j) or directly left (i, j-1).
                // dp[i-1][j] already holds the minimum for the rectangle ending at (i-1, j).
                // dp[i][j-1] already holds the minimum for the rectangle ending at (i, j-1).
                int minValFromPrevRegion = Integer.MAX_VALUE;
                if (i > 0) {
                    minValFromPrevRegion = Math.min(minValFromPrevRegion, dp[i-1][j]);
                }
                if (j > 0) {
                    minValFromPrevRegion = Math.min(minValFromPrevRegion, dp[i][j-1]);
                }

                // If minValFromPrevRegion is not Integer.MAX_VALUE, it means there exists
                // at least one valid (r1, c1) cell strictly before (i, j).
                if (minValFromPrevRegion != Integer.MAX_VALUE) {
                    maxScore = Math.max(maxScore, currentVal - minValFromPrevRegion);
                }

                // Update dp[i][j] for future calculations.
                // dp[i][j] should store the minimum (grid[x][y] - x - y) in the rectangle
                // from (0,0) to (i,j). This minimum is either currentVal itself,
                // or the minimum from the cell above, or the minimum from the cell to the left.
                dp[i][j] = currentVal;
                if (i > 0) {
                    dp[i][j] = Math.min(dp[i][j], dp[i-1][j]);
                }
                if (j > 0) {
                    dp[i][j] = Math.min(dp[i][j], dp[i][j-1]);
                }
            }
        }

        // The maximum score must be at least 0, as we can always choose (r1,c1) = (r2,c2)
        // for any cell, resulting in a score of 0.
        return Math.max(0, maxScore);
    }
}