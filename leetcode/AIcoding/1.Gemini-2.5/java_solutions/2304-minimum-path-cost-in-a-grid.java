class Solution {
    public int minPathCost(int[][] grid, int[][] moveCost) {
        int m = grid.length;
        int n = grid[0].length;

        int[][] dp = new int[m][n];

        // Initialize the first row of dp
        for (int j = 0; j < n; j++) {
            dp[0][j] = grid[0][j];
        }

        // Fill the dp table for subsequent rows
        for (int i = 1; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int minPrevRowCost = Integer.MAX_VALUE;
                // Iterate through all possible previous columns (k)
                for (int k = 0; k < n; k++) {
                    int prevCellVal = grid[i - 1][k];
                    // Cost to reach (i, j) from (i-1, k)
                    // is dp[i-1][k] (cost to reach prev cell)
                    // + moveCost[prevCellVal][j] (cost to move from prev cell value to current column j)
                    minPrevRowCost = Math.min(minPrevRowCost, dp[i - 1][k] + moveCost[prevCellVal][j]);
                }
                // Total cost to reach (i, j) is the minimum cost from previous row
                // plus the value of the current cell grid[i][j]
                dp[i][j] = grid[i][j] + minPrevRowCost;
            }
        }

        // The minimum path cost will be the minimum value in the last row of dp
        int minTotalCost = Integer.MAX_VALUE;
        for (int j = 0; j < n; j++) {
            minTotalCost = Math.min(minTotalCost, dp[m - 1][j]);
        }

        return minTotalCost;
    }
}