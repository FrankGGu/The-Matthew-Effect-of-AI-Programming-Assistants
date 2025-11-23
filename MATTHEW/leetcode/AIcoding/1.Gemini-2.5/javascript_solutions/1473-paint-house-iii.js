var minCost = function(houses, cost, m, n, target) {
    // dp[j][k] represents the minimum cost to paint the current house (house 'i')
    // with color 'j+1' (0-indexed 'j'), resulting in 'k' neighborhoods.
    // 'prevDp' stores the results for the previous house (house 'i-1').

    // Initialize prevDp for the first house (i = 0)
    // prevDp[j][k] where j is color index (0 to n-1), k is neighborhood count (1 to target)
    let prevDp = Array(n).fill(0).map(() => Array(target + 1).fill(Infinity));

    for (let j = 0; j < n; j++) { // Iterate through all possible colors for the first house
        // If house 0 is already painted and its color is not j+1, this state is invalid.
        if (houses[0] !== 0 && houses[0] !== j + 1) {
            continue;
        }

        // Calculate the cost to paint house 0 with color j+1.
        // If houses[0] is 0 (unpainted), use cost[0][j]. Otherwise, it's already painted, cost is 0.
        const currentPaintCost = (houses[0] === 0) ? cost[0][j] : 0;

        // For the first house, there's always 1 neighborhood.
        prevDp[j][1] = currentPaintCost;
    }

    // Iterate for houses from 1 to m-1
    for (let i = 1; i < m; i++) {
        // 'dp' will store the results for the current house 'i'.
        let dp = Array(n).fill(0).map(() => Array(target + 1).fill(Infinity));

        // Pre-calculate the minimum and second minimum costs from 'prevDp' for each neighborhood count.
        // This optimization reduces the inner loop from O(N) to O(1).
        // min1_costs[k_val] stores { cost, color_index } of the minimum cost for k_val neighborhoods at house i-1.
        // min2_costs[k_val] stores { cost, color_index } of the second minimum cost.
        const min1_costs = Array(target + 1).fill(null).map(() => ({ cost: Infinity, idx: -1 }));
        const min2_costs = Array(target + 1).fill(null).map(() => ({ cost: Infinity, idx: -1 }));

        for (let k_val = 1; k_val <= target; k_val++) {
            for (let prevJ = 0; prevJ < n; prevJ++) {
                const val = prevDp[prevJ][k_val];
                if (val < min1_costs[k_val].cost) {
                    min2_costs[k_val].cost = min1_costs[k_val].cost;
                    min2_costs[k_val].idx = min1_costs[k_val].idx;
                    min1_costs[k_val].cost = val;
                    min1_costs[k_val].idx = prevJ;
                } else if (val < min2_costs[k_val].cost) {
                    min2_costs[k_val].cost = val;
                    min2_costs[k_val].idx = prevJ;
                }
            }
        }

        for (let j = 0; j < n; j++) { // Iterate through all possible colors for the current house 'i'
            // If house 'i' is already painted and its color is not j+1, this state is invalid.
            if (houses[i] !== 0 && houses[i] !== j + 1) {
                continue;
            }

            // Calculate the cost to paint house 'i' with color j+1.
            const currentPaintCost = (houses[i] === 0) ? cost[i][j] : 0;

            for (let k = 1; k <= target; k++) { // Iterate through possible neighborhood counts
                // Case 1: Current house 'i' is painted with the same color as the previous house 'i-1'.
                // The number of neighborhoods 'k' remains the same.
                if (prevDp[j][k] !== Infinity) {
                    dp[j][k] = Math.min(dp[j][k], prevDp[j][k] + currentPaintCost);
                }

                // Case 2: Current house 'i' is painted with a different color than the previous house 'i-1'.
                // A new neighborhood is formed, so the previous house 'i-1' must have had 'k-1' neighborhoods.
                if (k > 1) {
                    let costFromPrevDifferentColor = Infinity;
                    // If the minimum cost for 'k-1' neighborhoods was from color 'j' (which is the current color),
                    // we must use the second minimum cost from 'prevDp[prevJ][k-1]' where prevJ != j.
                    if (min1_costs[k - 1].idx === j) {
                        costFromPrevDifferentColor = min2_costs[k - 1].cost;
                    } else {
                        // Otherwise, we can use the overall minimum cost for 'k-1' neighborhoods.
                        costFromPrevDifferentColor = min1_costs[k - 1].cost;
                    }

                    if (costFromPrevDifferentColor !== Infinity) {
                        dp[j][k] = Math.min(dp[j][k], costFromPrevDifferentColor + currentPaintCost);
                    }
                }
            }
        }
        // After processing all colors and neighborhoods for house 'i',
        // the current 'dp' becomes the 'prevDp' for the next iteration.
        prevDp = dp;
    }

    let minTotalCost = Infinity;
    // The final answer is the minimum cost among all possible colors for the last house (m-1)
    // with exactly 'target' neighborhoods.
    for (let j = 0; j < n; j++) {
        minTotalCost = Math.min(minTotalCost, prevDp[j][target]);
    }

    // If 'minTotalCost' is still Infinity, it means 'target' neighborhoods could not be formed.
    return minTotalCost === Infinity ? -1 : minTotalCost;
};