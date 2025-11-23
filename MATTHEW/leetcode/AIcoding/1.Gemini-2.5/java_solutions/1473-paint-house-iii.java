class Solution {
    public int minCost(int[] houses, int[][] cost, int m, int n, int target) {
        final long INF = 1_000_000_001L; // A value larger than any possible cost

        // dp_prev[j][k] represents the minimum cost to paint houses up to the previous house,
        // with the previous house painted color j, forming k neighborhoods.
        long[][] dp_prev = new long[n + 1][target + 1];
        // dp_curr[j][k] represents the minimum cost to paint houses up to the current house,
        // with the current house painted color j, forming k neighborhoods.
        long[][] dp_curr = new long[n + 1][target + 1];

        // Initialize dp_prev with INF
        for (int r = 0; r <= n; r++) {
            java.util.Arrays.fill(dp_prev[r], INF);
        }

        // Base case: painting the first house (house index 0)
        if (houses[0] != 0) { // If house 0 is already painted
            dp_prev[houses[0]][1] = 0;
        } else { // If house 0 is not painted
            for (int c = 1; c <= n; c++) {
                dp_prev[c][1] = cost[0][c - 1];
            }
        }

        // Iterate through houses from the second house (index 1) to the last
        for (int i = 1; i < m; i++) {
            // Initialize dp_curr for the current house with INF
            for (int r = 0; r <= n; r++) {
                java.util.Arrays.fill(dp_curr[r], INF);
            }

            // Precompute min1 and min2 for dp_prev for each neighborhood count k_prime
            // min1_prev_k[k_prime]: minimum cost for k_prime neighborhoods ending at previous house
            // min1_color_prev_k[k_prime]: color that achieved min1_prev_k[k_prime]
            // min2_prev_k[k_prime]: second minimum cost for k_prime neighborhoods ending at previous house
            long[] min1_prev_k = new long[target + 1];
            int[] min1_color_prev_k = new int[target + 1];
            long[] min2_prev_k = new long[target + 1];
            java.util.Arrays.fill(min1_prev_k, INF);
            java.util.Arrays.fill(min2_prev_k, INF);

            for (int k_prime = 1; k_prime <= target; k_prime++) {
                for (int prev_j = 1; prev_j <= n; prev_j++) {
                    if (dp_prev[prev_j][k_prime] < min1_prev_k[k_prime]) {
                        min2_prev_k[k_prime] = min1_prev_k[k_prime];
                        min1_prev_k[k_prime] = dp_prev[prev_j][k_prime];
                        min1_color_prev_k[k_prime] = prev_j;
                    } else if (dp_prev[prev_j][k_prime] < min2_prev_k[k_prime]) {
                        min2_prev_k[k_prime] = dp_prev[prev_j][k_prime];
                    }
                }
            }

            // Iterate through possible colors for the current house (j)
            for (int j = 1; j <= n; j++) {
                // If house i is already painted and its color is not j, skip this state
                if (houses[i] != 0 && houses[i] != j) {
                    continue;
                }

                // Calculate the cost to paint the current house with color j
                long current_paint_cost = (houses[i] == 0) ? cost[i][j - 1] : 0;

                // Iterate through possible number of neighborhoods (k)
                for (int k = 1; k <= target; k++) {
                    // Case 1: Current house has the same color as the previous house (j == prev_j)
                    // This means the number of neighborhoods does not increase.
                    if (dp_prev[j][k] != INF) {
                        dp_curr[j][k] = Math.min(dp_curr[j][k], dp_prev[j][k] + current_paint_cost);
                    }

                    // Case 2: Current house has a different color than the previous house (j != prev_j)
                    // This means a new neighborhood is formed.
                    // We need k-1 neighborhoods from the previous houses.
                    if (k > 1) {
                        long cost_from_prev_k_minus_1 = INF;

                        // If the best color for k-1 neighborhoods in the previous step was 'j',
                        // we must use the second best to ensure a different color.
                        if (min1_color_prev_k[k - 1] == j) {
                            cost_from_prev_k_minus_1 = min2_prev_k[k - 1];
                        } else { // Otherwise, we can use the best cost
                            cost_from_prev_k_minus_1 = min1_prev_k[k - 1];
                        }

                        if (cost_from_prev_k_minus_1 != INF) {
                            dp_curr[j][k] = Math.min(dp_curr[j][k], cost_from_prev_k_minus_1 + current_paint_cost);
                        }
                    }
                }
            }
            // Swap dp_prev and dp_curr for the next iteration
            long[][] temp = dp_prev;
            dp_prev = dp_curr;
            dp_curr = temp;
        }

        // Find the minimum total cost for target neighborhoods after painting all houses
        long min_total_cost = INF;
        for (int j = 1; j <= n; j++) {
            min_total_cost = Math.min(min_total_cost, dp_prev[j][target]);
        }

        return (min_total_cost == INF) ? -1 : (int) min_total_cost;
    }
}