class Solution {
    public int minCost(int[][] costs) {
        int n = costs.length;
        int m = costs[0].length;
        int[][] dp = new int[n][m];

        for (int j = 0; j < m; j++) {
            dp[0][j] = costs[0][j];
        }

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < m; j++) {
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = 0; k < m; k++) {
                    if (k != j) {
                        dp[i][j] = Math.min(dp[i][j], dp[i - 1][k] + costs[i][j]);
                    }
                }
            }
        }

        int minCost = Integer.MAX_VALUE;
        for (int j = 0; j < m; j++) {
            minCost = Math.min(minCost, dp[n - 1][j]);
        }

        return minCost;
    }
}