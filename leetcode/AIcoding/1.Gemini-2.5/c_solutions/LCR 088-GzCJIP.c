int minCostClimbingStairs(int* cost, int costSize) {
    if (costSize == 0) {
        return 0;
    }
    if (costSize == 1) {
        return cost[0];
    }

    // dp[i] represents the minimum cost to reach step i.
    // To optimize space, we only need the previous two values.
    // prev2 stores dp[i-2]
    // prev1 stores dp[i-1]
    int prev2 = cost[0];
    int prev1 = cost[1];

    for (int i = 2; i < costSize; i++) {
        // current_cost = min(cost to reach i-1, cost to reach i-2) + cost to step on i
        int current_cost = ((prev1 < prev2) ? prev1 : prev2) + cost[i];
        prev2 = prev1;
        prev1 = current_cost;
    }

    // The final answer is the minimum cost to reach either the last step (costSize-1)
    // or the second to last step (costSize-2), and then exit.
    // At this point, prev1 holds the min cost to reach cost[costSize-1]
    // and prev2 holds the min cost to reach cost[costSize-2].
    return (prev1 < prev2) ? prev1 : prev2;
}