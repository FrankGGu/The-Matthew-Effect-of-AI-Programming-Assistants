class Solution {
    public int minCostClimbingStairs(int[] cost) {
        int n = cost.length;

        // For space-optimized dynamic programming, we only need to keep track of
        // the minimum cost to reach the previous two steps.
        // Let prev2 be the minimum cost to reach step i-2.
        // Let prev1 be the minimum cost to reach step i-1.

        // Initialize base cases:
        // The minimum cost to reach step 0 (and pay its cost) is cost[0].
        int prev2 = cost[0];
        // The minimum cost to reach step 1 (and pay its cost) is cost[1].
        int prev1 = cost[1];

        // Iterate from the third step (index 2) up to the last step (index n-1).
        // For each step i, the minimum cost to reach it is its own cost
        // plus the minimum cost to reach either step i-1 or step i-2.
        for (int i = 2; i < n; i++) {
            // Calculate the minimum cost to reach the current step i.
            // This is cost[i] plus the minimum of (cost to reach i-1, cost to reach i-2).
            int currentCost = cost[i] + Math.min(prev1, prev2);

            // Update prev2 and prev1 for the next iteration:
            // The old prev1 becomes the new prev2.
            prev2 = prev1;
            // The currentCost becomes the new prev1.
            prev1 = currentCost;
        }

        // After iterating through all steps, prev1 will hold the minimum cost to reach
        // the last step (n-1), and prev2 will hold the minimum cost to reach the
        // second to last step (n-2).
        // To reach the "top of the floor" (which is one step beyond the last step),
        // we can either climb one step from the last step (n-1) or two steps from
        // the second to last step (n-2).
        // Therefore, the minimum cost to reach the top is the minimum of prev1 and prev2.
        return Math.min(prev1, prev2);
    }
}