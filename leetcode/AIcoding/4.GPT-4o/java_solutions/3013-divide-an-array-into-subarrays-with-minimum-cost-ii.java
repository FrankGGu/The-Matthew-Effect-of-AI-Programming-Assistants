class Solution {
    public int minCost(int[][] costs) {
        int n = costs.length;
        if (n == 0) return 0;

        int[] dp = new int[n];
        dp[0] = Math.min(costs[0][0], Math.min(costs[0][1], costs[0][2]));

        for (int i = 1; i < n; i++) {
            dp[i] = Integer.MAX_VALUE;
            for (int j = 0; j < 3; j++) {
                for (int k = 0; k < 3; k++) {
                    if (j != k) {
                        dp[i] = Math.min(dp[i], dp[i - 1] + costs[i][j]);
                    }
                }
            }
        }

        return dp[n - 1];
    }
}