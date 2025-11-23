class Solution {
    public int minCost(int[] houses, int[][] cost, int m, int n, int target) {
        int[][][] dp = new int[m][target + 1][n + 1];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j <= target; j++) {
                for (int k = 0; k <= n; k++) {
                    dp[i][j][k] = -1;
                }
            }
        }

        int result = solve(houses, cost, m, n, target, 0, 0, 0, dp);
        return result == Integer.MAX_VALUE ? -1 : result;
    }

    private int solve(int[] houses, int[][] cost, int m, int n, int target, int index, int neighborhoods, int prevColor, int[][][] dp) {
        if (index == m) {
            return neighborhoods == target ? 0 : Integer.MAX_VALUE;
        }

        if (neighborhoods > target) {
            return Integer.MAX_VALUE;
        }

        if (dp[index][neighborhoods][prevColor] != -1) {
            return dp[index][neighborhoods][prevColor];
        }

        int minCost = Integer.MAX_VALUE;

        if (houses[index] != 0) {
            int newNeighborhoods = neighborhoods;
            if (houses[index] != prevColor) {
                newNeighborhoods++;
            }
            int currentCost = solve(houses, cost, m, n, target, index + 1, newNeighborhoods, houses[index], dp);
            minCost = Math.min(minCost, currentCost);
        } else {
            for (int color = 1; color <= n; color++) {
                int newNeighborhoods = neighborhoods;
                if (color != prevColor) {
                    newNeighborhoods++;
                }
                int currentCost = solve(houses, cost, m, n, target, index + 1, newNeighborhoods, color, dp);
                if (currentCost != Integer.MAX_VALUE) {
                    minCost = Math.min(minCost, currentCost + cost[index][color - 1]);
                }
            }
        }

        return dp[index][neighborhoods][prevColor] = minCost;
    }
}