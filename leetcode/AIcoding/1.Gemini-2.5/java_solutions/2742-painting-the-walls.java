import java.util.Arrays;

class Solution {
    public long paintWalls(int[] cost, int[] time) {
        int n = cost.length;
        int maxTimeSum = 0;
        for (int t : time) {
            maxTimeSum += t;
        }

        // dp[j] will store the minimum cost to achieve a total "wall coverage" of j.
        // "Wall coverage" for a wall i is (1 + time[i]).
        // We need the total wall coverage to be at least N.
        // The maximum possible sum of (1 + time[i]) is N * (1 + max_time_val).
        // Max time_val = 500. So max_coverage_sum = 500 * (1 + 500) = 250500.
        int maxCapacity = n + maxTimeSum; // Upper bound for the sum of (1 + time[i])
                                          // A tighter bound is N * (1 + max(time[i]))
                                          // Let's use the tighter bound for array size.

        int maxPossibleItemWeight = 1 + 500; // max time[i] is 500
        int dpSize = n * maxPossibleItemWeight + 1;

        long[] dp = new long[dpSize];
        Arrays.fill(dp, Long.MAX_VALUE / 2); // Use half MAX_VALUE to prevent overflow during addition
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            int currentCost = cost[i];
            int currentWeight = 1 + time[i]; // The "value" this wall contributes to coverage

            // Iterate backwards to simulate 0/1 knapsack (each item used at most once)
            for (int j = dpSize - 1; j >= currentWeight; j--) {
                if (dp[j - currentWeight] != Long.MAX_VALUE / 2) {
                    dp[j] = Math.min(dp[j], dp[j - currentWeight] + currentCost);
                }
            }
        }

        long minTotalCost = Long.MAX_VALUE / 2;
        // We need to find the minimum cost for any 'j' where total "wall coverage" is at least N.
        for (int j = n; j < dpSize; j++) {
            minTotalCost = Math.min(minTotalCost, dp[j]);
        }

        return minTotalCost;
    }
}