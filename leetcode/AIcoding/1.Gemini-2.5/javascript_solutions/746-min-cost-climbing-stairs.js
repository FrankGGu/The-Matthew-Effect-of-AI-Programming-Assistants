var minCostClimbingStairs = function(cost) {
    const n = cost.length;

    // dp[i] will store the minimum cost to reach step i.
    // We can optimize space by only keeping track of the last two steps' costs.
    let prev2 = cost[0]; // Represents dp[0]
    let prev1 = cost[1]; // Represents dp[1]

    // Since the problem states cost.length will be at least 2,
    // prev2 and prev1 are always valid.

    // Iterate from the third step up to the last step (index n-1)
    for (let i = 2; i < n; i++) {
        const current = cost[i] + Math.min(prev1, prev2);
        prev2 = prev1;
        prev1 = current;
    }

    // The minimum cost to reach the top of the floor is the minimum of
    // reaching the last step (n-1) or the second to last step (n-2).
    // These are represented by prev1 and prev2 after the loop.
    return Math.min(prev1, prev2);
};