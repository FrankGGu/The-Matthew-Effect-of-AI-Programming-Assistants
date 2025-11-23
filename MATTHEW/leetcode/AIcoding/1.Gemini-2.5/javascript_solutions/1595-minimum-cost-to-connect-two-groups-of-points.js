var connectTwoGroups = function(cost) {
    const m = cost.length; // Number of points in group 1
    const n = cost[0].length; // Number of points in group 2

    // Precompute the cost for each point 'i' in group 1 to connect to a subset 'subMask' of group 2 points.
    // costToConnect[i][subMask] will store the sum of costs cost[i][j] for all j where the j-th bit is set in subMask.
    // This precomputation takes O(m * (1 << n) * n) time.
    const costToConnect = Array(m).fill(0).map(() => Array(1 << n).fill(0));
    for (let i = 0; i < m; i++) {
        for (let subMask = 1; subMask < (1 << n); subMask++) {
            let currentPointCost = 0;
            for (let j = 0; j < n; j++) {
                if ((subMask >> j) & 1) { // If j-th bit is set in subMask
                    currentPointCost += cost[i][j];
                }
            }
            costToConnect[i][subMask] = currentPointCost;
        }
    }

    // dp[i][mask] will store the minimum cost to connect the first 'i' points
    // from group 1 such that the points in group 2 represented by 'mask' are covered.
    // 'i' ranges from 0 to m.
    // 'mask' ranges from 0 to (1 << n) - 1.
    // Initialize with Infinity, as we are looking for minimum cost.
    const dp = Array(m + 1).fill(0).map(() => Array(1 << n).fill(Infinity));

    // Base case: 0 cost to connect 0 points from group 1 and cover 0 points from group 2.
    dp[0][0] = 0;

    // Iterate through each point in group 1 (from index 0 to m-1)
    for (let i = 0; i < m; i++) {
        // Iterate through all possible masks for group 2 points that were covered by the first 'i' points
        for (let prevMask = 0; prevMask < (1 << n); prevMask++) {
            // If we haven't found a way to reach this state (cost is Infinity), skip it
            if (dp[i][prevMask] === Infinity) {
                continue;
            }

            // Now, consider connecting the (i+1)-th point from group 1 (at 0-indexed position 'i').
            // This point 'i' must connect to at least one point in group 2.
            // It can connect to any non-empty subset of points in group 2.
            // Iterate through all possible non-empty subsets of group 2 points (subMask) that point 'i' connects to.
            // This loop takes O(1 << n) time.
            for (let subMask = 1; subMask < (1 << n); subMask++) { // subMask must be at least 1 (connect to at least one point)
                const newMask = prevMask | subMask; // The new set of covered group 2 points
                // Update dp[i + 1][newMask] with the minimum cost found so far.
                // The cost is dp[i][prevMask] (cost to connect first 'i' points)
                // plus costToConnect[i][subMask] (cost for point 'i' to connect to points in 'subMask').
                dp[i + 1][newMask] = Math.min(dp[i + 1][newMask], dp[i][prevMask] + costToConnect[i][subMask]);
            }
        }
    }

    // The final answer is the minimum cost to connect all 'm' points from group 1
    // such that all 'n' points in group 2 are covered.
    // This corresponds to dp[m][(1 << n) - 1], where (1 << n) - 1 is the mask with all 'n' bits set.
    return dp[m][(1 << n) - 1];
};