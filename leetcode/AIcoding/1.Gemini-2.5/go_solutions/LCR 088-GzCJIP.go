func minCostClimbingStairs(cost []int) int {
    n := len(cost)

    // dp0 represents the minimum cost to reach the step (i-2) and pay its cost.
    // dp1 represents the minimum cost to reach the step (i-1) and pay its cost.
    // We initialize them with the costs of the first two steps, as these are our starting options.
    dp0 := cost[0]
    dp1 := cost[1]

    // Iterate from the third step (index 2) up to the last step (index n-1).
    // For each step i, the minimum cost to reach it is cost[i] plus the minimum
    // of the costs to reach the previous two steps (i-1 or i-2).
    for i := 2; i < n; i++ {
        currentCost := cost[i] + min(dp0, dp1)
        // Update dp0 to be the previous dp1 (cost to reach i-1)
        dp0 = dp1
        // Update dp1 to be the current calculated cost (cost to reach i)
        dp1 = currentCost
    }

    // After iterating through all steps, dp0 will hold the minimum cost to reach step (n-2)
    // and dp1 will hold the minimum cost to reach step (n-1).
    // To reach the "top of the floor" (which is effectively one step beyond the last step),
    // we can either climb from step (n-1) or step (n-2).
    // The minimum of these two values is our final answer.
    return min(dp0, dp1)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}