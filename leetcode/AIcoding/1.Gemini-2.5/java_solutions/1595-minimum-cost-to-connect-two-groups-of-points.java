import java.util.List;
import java.util.Arrays;

class Solution {
    public int connectTwoGroups(List<List<Integer>> cost) {
        int n = cost.size();
        int m = cost.get(0).size();

        // dp[i][mask] represents the minimum cost to connect the first 'i' points
        // from group1 (group1[0] to group1[i-1]) such that the points in group2
        // represented by 'mask' are connected.
        // The connections for group1[0]...group1[i-1] are made, and their costs are summed.
        // Each group1[k] (for k < i) is connected to exactly one group2 point.
        // The mask indicates which group2 points have been touched by group1[0]...group1[i-1].
        int[][] dp = new int[n + 1][1 << m];

        // Initialize dp table with a large value to represent infinity.
        // Using Integer.MAX_VALUE / 2 to prevent overflow during addition.
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2);
        }

        // Base case: 0 cost to connect 0 points from group1 and cover 0 points from group2.
        dp[0][0] = 0;

        // Iterate through each point in group1
        for (int i = 0; i < n; i++) { // Current point in group1 is cost[i]
            // Iterate through all possible masks for group2 points covered by group1[0...i-1]
            for (int mask = 0; mask < (1 << m); mask++) {
                // If dp[i][mask] is infinity, it means this state is unreachable, so skip.
                if (dp[i][mask] == Integer.MAX_VALUE / 2) {
                    continue;
                }

                // For the current point group1[i], it must be connected to at least one point in group2.
                // In this DP approach, we connect group1[i] to exactly one group2[j].
                // This connection adds cost[i][j] to the total.
                for (int j = 0; j < m; j++) { // Connect group1[i] to group2[j]
                    int newMask = mask | (1 << j); // Update the mask to include group2[j]

                    // Update dp[i+1][newMask] with the minimum cost
                    dp[i + 1][newMask] = Math.min(dp[i + 1][newMask], dp[i][mask] + cost.get(i).get(j));
                }
            }
        }

        // The final answer is the minimum cost to connect all 'n' points from group1
        // such that all 'm' points in group2 are covered (represented by a full mask).
        // This ensures:
        // 1. Each group1 point is connected to exactly one group2 point (by DP structure).
        // 2. Each group2 point is connected to at least one group1 point (by final mask).
        // 3. The total cost is the sum of costs of these unique connections.
        return dp[n][(1 << m) - 1];
    }
}