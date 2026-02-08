var findPermutation = function(cost) {
    const n = cost.length;

    // dp[mask][last_val] stores the minimum cost to form a permutation
    // of values represented by 'mask', where 'last_val' is the value
    // placed at p[k-1], where k is the number of set bits in 'mask'.
    // Initialize with a large value (infinity).
    const dp = Array(1 << n).fill(0).map(() => Array(n).fill(Infinity));

    // Helper function to count set bits in a number (popcount)
    function countSetBits(num) {
        let count = 0;
        while (num > 0) {
            num &= (num - 1); // Brian Kernighan's algorithm
            count++;
        }
        return count;
    }

    // Base cases: placing the first element p[0]
    // For each possible value j for p[0]
    for (let j = 0; j < n; j++) {
        dp[1 << j][j] = cost[0][j];
    }

    // Iterate through all possible masks from 1 up to (1 << n) - 1
    // A mask represents the set of values already used in the permutation prefix.
    for (let mask = 1; mask < (1 << n); mask++) {
        // curr_idx is the index in the permutation p we are about to fill.
        // It's equal to the number of elements already placed (count of set bits in mask).
        const curr_idx = countSetBits(mask);

        // If we have already placed all n elements, this mask is complete for a prefix.
        // We will collect the final answer at the end when mask is (1 << n) - 1.
        if (curr_idx === n) {
            continue;
        }

        // Iterate through all possible values 'prev_val' that could have been placed
        // at p[curr_idx - 1] (the last position in the current prefix).
        for (let prev_val = 0; prev_val < n; prev_val++) {
            // Check if 'prev_val' is part of the current 'mask'
            // and if a valid path to this state exists (i.e., dp[mask][prev_val] is not Infinity).
            if (!((mask >> prev_val) & 1) || dp[mask][prev_val] === Infinity) {
                continue;
            }

            // Iterate through all possible values 'next_val' that can be placed
            // at p[curr_idx]. 'next_val' must not be in 'mask' yet.
            for (let next_val = 0; next_val < n; next_val++) {
                if (!((mask >> next_val) & 1)) { // If next_val is not in mask
                    const new_mask = mask | (1 << next_val);
                    let current_cost_addition = cost[curr_idx][next_val]; // Direct assignment cost: cost[curr_idx][p[curr_idx]]

                    // Add inversion-like costs: sum(cost[curr_idx][p[j]]) for all j < curr_idx
                    // such that p[curr_idx] < p[j].
                    // Here, p[curr_idx] is 'next_val', and p[j] are the values 'v' already in 'mask'.
                    for (let v = 0; v < n; v++) {
                        if (((mask >> v) & 1) && v > next_val) {
                            current_cost_addition += cost[curr_idx][v];
                        }
                    }

                    // Update the DP table with the minimum cost to reach this new state.
                    dp[new_mask][next_val] = Math.min(
                        dp[new_mask][next_val],
                        dp[mask][prev_val] + current_cost_addition
                    );
                }
            }
        }
    }

    // After filling the DP table, the minimum cost for a complete permutation
    // will be found in dp[(1 << n) - 1][j] for any possible last value j.
    let min_total_cost = Infinity;
    const final_mask = (1 << n) - 1; // Mask where all bits are set
    for (let j = 0; j < n; j++) {
        min_total_cost = Math.min(min_total_cost, dp[final_mask][j]);
    }

    return min_total_cost;
};