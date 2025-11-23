class Solution {
    public int minPathCost(int[][] grid, int[][] moveCost) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[m][n];

        for (int j = 0; j < n; j++) {
            dp[0][j] = grid[0][j];
        }

        for (int i = 1; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int minCost = Integer.MAX_VALUE;
                for (int k = 0; k < n; k++) {
                    int cost = dp[i-1][k] + moveCost[grid[i-1][k]][j] + grid[i][j];
                    minCost = Math.min(minCost, cost);
                }
                dp[i][j] = minCost;
            }
        }

        int result = Integer.MAX_VALUE;
        for (int j = 0; j < n; j++) {
            result = Math.min(result, dp[m-1][j]);
        }

        return result;
    }
}