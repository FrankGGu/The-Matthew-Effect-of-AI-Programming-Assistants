class Solution {
    public int uniquePathsWithObstacles(int[][] obstacleGrid) {
        int m = obstacleGrid.length;
        int n = obstacleGrid[0].length;

        // If the starting cell is an obstacle, there are no paths.
        if (obstacleGrid[0][0] == 1) {
            return 0;
        }

        // Create a DP table to store the number of unique paths to each cell.
        // Initialize with 0s.
        int[][] dp = new int[m][n];

        // Base case: The starting cell has 1 path to itself.
        dp[0][0] = 1;

        // Fill the first row
        for (int j = 1; j < n; j++) {
            // If the current cell is not an obstacle and the previous cell in the row was reachable
            if (obstacleGrid[0][j] == 0 && dp[0][j - 1] == 1) {
                dp[0][j] = 1;
            }
        }

        // Fill the first column
        for (int i = 1; i < m; i++) {
            // If the current cell is not an obstacle and the previous cell in the column was reachable
            if (obstacleGrid[i][0] == 0 && dp[i - 1][0] == 1) {
                dp[i][0] = 1;
            }
        }

        // Fill the rest of the DP table
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                // If the current cell is not an obstacle
                if (obstacleGrid[i][j] == 0) {
                    dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
                }
                // If it's an obstacle, dp[i][j] remains 0 (default initialized value)
            }
        }

        // The number of unique paths to the bottom-right corner
        return dp[m - 1][n - 1];
    }
}