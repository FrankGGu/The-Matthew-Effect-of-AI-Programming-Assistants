class Solution {
    public int minCost(int[] houses, int[][] cost, int m, int n, int target) {
        // dp[i][j][k] represents the minimum cost to paint houses from 0 to i,
        // where house i is painted with color j (0-indexed), and there are k neighborhoods.
        // Initialize with a large value to represent infinity.
        long[][][] dp = new long[m][n][target + 1];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k <= target; k++) {
                    dp[i][j][k] = Long.MAX_VALUE;
                }
            }
        }

        // Base case: painting the first house (house 0)
        if (houses[0] == 0) { // House 0 is unpainted
            for (int c = 0; c < n; c++) {
                dp[0][c][1] = cost[0][c];
            }
        } else { // House 0 is already painted
            dp[0][houses[0] - 1][1] = 0;
        }

        // Iterate through houses from the second one (index 1)
        for (int i = 1; i < m; i++) {
            // Arrays to store the first and second minimum costs from the previous house (i-1)
            // for each number of neighborhoods (k).
            // minCost1[k] = {cost, color_idx}
            // minCost2[k] = {cost, color_idx}
            long[][] minCost1 = new long[target + 1][2];
            long[][] minCost2 = new long[target + 1][2];

            for (int k = 1; k <= target; k++) {
                minCost1[k][0] = Long.MAX_VALUE; minCost1[k][1] = -1;
                minCost2[k][0] = Long.MAX_VALUE; minCost2[k][1] = -1;

                for (int prevJ = 0; prevJ < n; prevJ++) {
                    if (dp[i - 1][prevJ][k] == Long.MAX_VALUE) {
                        continue;
                    }

                    if (dp[i - 1][prevJ][k] < minCost1[k][0]) {
                        minCost2[k][0] = minCost1[k][0];
                        minCost2[k][1] = minCost1[k][1];
                        minCost1[k][0] = dp[i - 1][prevJ][k];
                        minCost1[k][1] = prevJ;
                    } else if (dp[i - 1][prevJ][k] < minCost2[k][0]) {
                        minCost2[k][0] = dp[i - 1][prevJ][k];
                        minCost2[k][1] = prevJ;
                    }
                }
            }

            // Iterate through current house's color (j) and number of neighborhoods (k)
            for (int j = 0; j < n; j++) { // Current color for house i (0-indexed)
                for (int k = 1; k <= target; k++) { // Number of neighborhoods up to house i

                    long currentHousePaintCost = 0;
                    boolean isHouseIPainted = (houses[i] != 0);

                    if (isHouseIPainted) {
                        if (houses[i] - 1 != j) { // House i is already painted with a different color
                            continue; // This state is impossible
                        }
                        // If houses[i]-1 == j, cost is 0 as it's already painted.
                    } else { // House i is unpainted
                        currentHousePaintCost = cost[i][j];
                    }

                    // Option 1: House i has the same color as the previous house (i-1)
                    // The number of neighborhoods remains k.
                    if (dp[i - 1][j][k] != Long.MAX_VALUE) {
                        dp[i][j][k] = Math.min(dp[i][j][k], dp[i - 1][j][k] + currentHousePaintCost);
                    }

                    // Option 2: House i has a different color from the previous house (i-1)
                    // This forms a new neighborhood. So, the previous state must have k-1 neighborhoods.
                    if (k > 1) { // We need at least 2 neighborhoods to form a new one
                        if (minCost1[k - 1][1] != j) { // The first minimum previous color is different from current color j
                            if (minCost1[k - 1][0] != Long.MAX_VALUE) {
                                dp[i][j][k] = Math.min(dp[i][j][k], minCost1[k - 1][0] + currentHousePaintCost);
                            }
                        } else { // The first minimum previous color is the same as current color j, so use the second minimum
                            if (minCost2[k - 1][0] != Long.MAX_VALUE) {
                                dp[i][j][k] = Math.min(dp[i][j][k], minCost2[k - 1][0] + currentHousePaintCost);
                            }
                        }
                    }
                }
            }
        }

        // Find the minimum cost for the last house (m-1) with 'target' neighborhoods
        long minTotalCost = Long.MAX_VALUE;
        for (int j = 0; j < n; j++) {
            minTotalCost = Math.min(minTotalCost, dp[m - 1][j][target]);
        }

        return minTotalCost == Long.MAX_VALUE ? -1 : (int) minTotalCost;
    }
}