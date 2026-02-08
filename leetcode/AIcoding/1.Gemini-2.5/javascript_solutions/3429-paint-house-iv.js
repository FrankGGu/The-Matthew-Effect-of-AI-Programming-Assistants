var minCost = function(houses, cost, m, n, target) {
    // dp[i][j][k] represents the minimum cost to paint houses from 0 to i,
    // with house i being painted with color j (0-indexed),
    // and having k neighborhoods formed up to house i.
    // Initialize dp table with Infinity.
    const dp = Array(m).fill(0).map(() => 
                 Array(n).fill(0).map(() => 
                     Array(target + 1).fill(Infinity)));

    // Base case: For the first house (i = 0)
    // If houses[0] is already colored
    if (houses[0] !== 0) {
        const color = houses[0] - 1; // Convert to 0-indexed color
        dp[0][color][1] = 0; // Cost is 0 as it's pre-colored
    } else { // houses[0] needs to be painted
        for (let c = 0; c < n; c++) {
            dp[0][c][1] = cost[0][c]; // Cost is the paint cost
        }
    }

    // Iterate for houses from the second house (i = 1) up to the last house (m-1)
    for (let i = 1; i < m; i++) {
        // For each house `i`, we need to compute `dp[i][...]` based on `dp[i-1][...]`.
        // To optimize the transition, we precompute the two minimum costs and their colors
        // from the previous house's DP states for each possible neighborhood count `k_prev`.
        const min1_dp_prev_k = Array(target + 1).fill(Infinity);
        const min1_dp_prev_k_idx = Array(target + 1).fill(-1); // Stores the color index that achieved min1_dp_prev_k
        const min2_dp_prev_k = Array(target + 1).fill(Infinity);

        for (let k_prev = 1; k_prev <= target; k_prev++) {
            for (let prevColor = 0; prevColor < n; prevColor++) {
                const val = dp[i-1][prevColor][k_prev];
                if (val === Infinity) continue; // Skip unreachable states

                if (val < min1_dp_prev_k[k_prev]) {
                    // Found a new minimum, shift current min1 to min2
                    min2_dp_prev_k[k_prev] = min1_dp_prev_k[k_prev];
                    min1_dp_prev_k[k_prev] = val;
                    min1_dp_prev_k_idx[k_prev] = prevColor;
                } else if (val < min2_dp_prev_k[k_prev]) {
                    // Found a new second minimum
                    min2_dp_prev_k[k_prev] = val;
                }
            }
        }

        // Iterate for the current house's neighborhood count (k) and color (currentColor)
        for (let k = 1; k <= target; k++) {
            for (let currentColor = 0; currentColor < n; currentColor++) {
                // If house i is already colored and its color is not currentColor,
                // then this state is invalid, so we skip it.
                if (houses[i] !== 0 && houses[i] - 1 !== currentColor) {
                    continue;
                }

                // Calculate the cost to paint the current house if it's not pre-colored
                const currentHousePaintCost = (houses[i] === 0) ? cost[i][currentColor] : 0;

                // Case 1: The current house has the same color as the previous house.
                // This means no new neighborhood is formed, so the neighborhood count remains `k`.
                const costSameColor = dp[i-1][currentColor][k];
                if (costSameColor !== Infinity) {
                    dp[i][currentColor][k] = Math.min(dp[i][currentColor][k], costSameColor + currentHousePaintCost);
                }

                // Case 2: The current house has a different color than the previous house.
                // This forms a new neighborhood. Thus, the previous house must have had `k-1` neighborhoods.
                if (k > 1) { // A new neighborhood can only be formed if k is at least 2
                    let costDiffColor = Infinity;
                    // If the current color is the same as the color that achieved min1 for `k-1` neighborhoods,
                    // we must use the second minimum cost from `k-1` neighborhoods.
                    if (currentColor === min1_dp_prev_k_idx[k-1]) {
                        costDiffColor = min2_dp_prev_k[k-1];
                    } else {
                        // Otherwise, we can use the overall minimum cost from `k-1` neighborhoods.
                        costDiffColor = min1_dp_prev_k[k-1];
                    }

                    if (costDiffColor !== Infinity) {
                        dp[i][currentColor][k] = Math.min(dp[i][currentColor][k], costDiffColor + currentHousePaintCost);
                    }
                }
            }
        }
    }

    // After filling the DP table, find the minimum cost among all possible colors
    // for the last house (m-1) with exactly `target` neighborhoods.
    let minTotalCost = Infinity;
    for (let c = 0; c < n; c++) {
        minTotalCost = Math.min(minTotalCost, dp[m-1][c][target]);
    }

    // If minTotalCost is still Infinity, it means no valid solution was found.
    return minTotalCost === Infinity ? -1 : minTotalCost;
};