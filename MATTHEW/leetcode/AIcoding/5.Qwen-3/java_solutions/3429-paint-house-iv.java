public class Solution {
    public int minCostToPaintHouse(int[][] costs) {
        if (costs == null || costs.length == 0) return 0;

        int n = costs.length;
        int k = costs[0].length;

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < k; j++) {
                int minPrev = Integer.MAX_VALUE;
                for (int l = 0; l < k; l++) {
                    if (l != j) {
                        minPrev = Math.min(minPrev, costs[i - 1][l]);
                    }
                }
                costs[i][j] += minPrev;
            }
        }

        int minCost = Integer.MAX_VALUE;
        for (int cost : costs[n - 1]) {
            minCost = Math.min(minCost, cost);
        }

        return minCost;
    }
}