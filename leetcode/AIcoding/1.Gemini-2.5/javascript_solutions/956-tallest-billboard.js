var tallestBillboard = function(rods) {
    let totalSum = 0;
    for (const rod of rods) {
        totalSum += rod;
    }

    // dp[diff] stores the maximum sum of rods for billboard 1 (s1)
    // such that s1 - s2 = diff.
    // The 'diff' can range from -totalSum to +totalSum.
    // We use an offset to map 'diff' to array indices [0, 2*totalSum].
    const offset = totalSum;
    let dp = new Array(2 * totalSum + 1).fill(Number.MIN_SAFE_INTEGER);

    // Base case: diff = 0, s1 = 0, s2 = 0
    dp[offset] = 0;

    for (const rod of rods) {
        // Create a new dp array for the current rod, initialized with previous states.
        // This allows us to consider not using the current rod for any billboard.
        const next_dp = [...dp]; 

        // Iterate through all possible differences (indices)
        for (let d = 0; d < dp.length; d++) {
            if (dp[d] === Number.MIN_SAFE_INTEGER) {
                continue; // This state is unreachable from previous rods
            }

            const current_s1 = dp[d];
            const current_diff = d - offset;

            // Option 1: Add the current rod to billboard 1
            // new_diff = current_diff + rod
            // new_s1 = current_s1 + rod
            const new_diff_idx_plus = current_diff + rod + offset;
            next_dp[new_diff_idx_plus] = Math.max(next_dp[new_diff_idx_plus], current_s1 + rod);

            // Option 2: Add the current rod to billboard 2
            // new_diff = current_diff - rod
            // new_s1 = current_s1 (s1 doesn't change, s2 increases)
            const new_diff_idx_minus = current_diff - rod + offset;
            next_dp[new_diff_idx_minus] = Math.max(next_dp[new_diff_idx_minus], current_s1);
        }
        // Update dp for the next iteration
        dp = next_dp;
    }

    // The result is the maximum s1 when the difference between s1 and s2 is 0
    return dp[offset];
};