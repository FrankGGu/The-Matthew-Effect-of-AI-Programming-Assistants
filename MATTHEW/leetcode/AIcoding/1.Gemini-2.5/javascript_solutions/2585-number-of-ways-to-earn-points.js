var numberOfWaysToEarnPoints = function(types, target) {
    const MOD = 10 ** 9 + 7;

    // dp[j] will store the number of ways to earn exactly j points.
    // Initialize dp[0] to 1, as there's one way to earn 0 points (by taking no items).
    // All other dp[j] are initialized to 0.
    let dp = new Array(target + 1).fill(0);
    dp[0] = 1;

    // Iterate through each type of item available.
    for (const [count, points] of types) {
        // Create a new DP array for the current iteration to store results
        // using items processed so far, including the current type.
        // This prevents using items of the current type multiple times within
        // the same item type's calculation for a single dp state.
        const next_dp = new Array(target + 1).fill(0);

        // Iterate through all possible point totals from 0 up to target.
        for (let current_points = 0; current_points <= target; current_points++) {
            // If there's no way to achieve 'current_points' using previous item types,
            // then we cannot build upon this state with the current item type.
            if (dp[current_points] === 0) {
                continue;
            }

            // For each 'current_points' achievable, try adding 0, 1, ..., 'count'
            // items of the current type.
            for (let k = 0; k <= count; k++) {
                const new_total_points = current_points + k * points;

                // If the new total points do not exceed the target, update next_dp.
                if (new_total_points <= target) {
                    next_dp[new_total_points] = (next_dp[new_total_points] + dp[current_points]) % MOD;
                } else {
                    // Optimization: If adding 'k' items already exceeds the target,
                    // adding 'k+1' or more items will also exceed it.
                    break;
                }
            }
        }
        // After processing the current item type, update dp to next_dp
        // for the next iteration (next item type).
        dp = next_dp;
    }

    // The final answer is the number of ways to earn exactly 'target' points.
    return dp[target];
};