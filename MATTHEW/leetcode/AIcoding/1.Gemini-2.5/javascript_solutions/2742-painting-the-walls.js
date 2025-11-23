var paintWalls = function(cost, time) {
    const n = cost.length;

    // dp[j] will store the minimum cost to paint 'j' walls.
    // Initialize dp array with Infinity, except for dp[0] which is 0
    // (cost to paint 0 walls is 0).
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    // Iterate through each wall
    for (let i = 0; i < n; i++) {
        const currentCost = cost[i];
        const currentTime = time[i];

        // This is a 0/1 knapsack-like problem.
        // If we choose to use the paid painter for wall 'i':
        // - We pay currentCost.
        // - Wall 'i' is painted by the paid painter.
        // - During the currentTime units the paid painter is busy,
        //   the free painter can paint currentTime *additional* walls.
        // - So, this action effectively paints (1 + currentTime) walls in total.
        // We iterate 'j' downwards to ensure each wall (item) is considered only once.
        for (let j = n; j >= 0; j--) {
            // Calculate the number of walls that need to be painted before this action.
            // max(0, j - (1 + currentTime)) ensures we don't go below 0 walls,
            // as painting (1 + currentTime) walls might cover more than 'j' walls.
            const prevWallsNeeded = Math.max(0, j - (1 + currentTime));

            // Update dp[j] with the minimum cost:
            // - Either we don't use the paid painter for wall 'i' (dp[j] remains its current value),
            // - Or we use the paid painter for wall 'i' (cost is dp[prevWallsNeeded] + currentCost).
            if (dp[prevWallsNeeded] !== Infinity) {
                dp[j] = Math.min(dp[j], dp[prevWallsNeeded] + currentCost);
            }
        }
    }

    // The minimum cost to paint all 'n' walls is dp[n].
    return dp[n];
};