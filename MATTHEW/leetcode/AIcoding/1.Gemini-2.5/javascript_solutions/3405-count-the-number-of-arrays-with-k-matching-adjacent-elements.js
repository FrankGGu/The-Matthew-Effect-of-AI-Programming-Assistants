var numberOfArrays = function(n, m, k) {
    const MOD = 10**9 + 7;

    // dp[last_val][matches] stores the number of ways to form an array of the current length
    // ending with `last_val` and having `matches` adjacent matching elements.
    // The dimensions are (m+1) x (k+1).
    let dp = Array(m + 1).fill(0).map(() => Array(k + 1).fill(0));

    // Base case: For an array of length 1 (index 0),
    // any value from 1 to m can be chosen. There are 0 adjacent matches.
    for (let val = 1; val <= m; val++) {
        dp[val][0] = 1;
    }

    // Iterate for array length from 2 up to n
    // `i` represents the current length (from 1 to n-1, total `n` elements)
    for (let i = 1; i < n; i++) {
        // next_dp will store the results for the current length `i+1`
        let next_dp = Array(m + 1).fill(0).map(() => Array(k + 1).fill(0));

        // Pre-calculate sum of dp[prev_val][matches] for all prev_val for the previous length.
        // This optimizes the "Case 2" transition.
        let sum_prev_dp_for_matches = Array(k + 1).fill(0);
        for (let prev_val = 1; prev_val <= m; prev_val++) {
            for (let matches = 0; matches <= k; matches++) {
                sum_prev_dp_for_matches[matches] = (sum_prev_dp_for_matches[matches] + dp[prev_val][matches]) % MOD;
            }
        }

        // Fill next_dp for the current length `i+1`
        for (let current_val = 1; current_val <= m; current_val++) {
            for (let current_matches = 0; current_matches <= k; current_matches++) {

                // Case 1: The current element `current_val` matches the previous element.
                // This means the previous element was also `current_val`,
                // and we had `current_matches - 1` matches up to the previous step.
                if (current_matches > 0) {
                    next_dp[current_val][current_matches] = (next_dp[current_val][current_matches] + dp[current_val][current_matches - 1]) % MOD;
                }

                // Case 2: The current element `current_val` does NOT match the previous element.
                // This means the previous element `prev_val` was anything other than `current_val`,
                // and we had `current_matches` matches up to the previous step.
                // Sum of dp[prev_val][current_matches] for all prev_val != current_val
                // This can be computed as (total sum for current_matches) - (dp[current_val][current_matches]).
                let contribution_from_different = (sum_prev_dp_for_matches[current_matches] - dp[current_val][current_matches] + MOD) % MOD;
                next_dp[current_val][current_matches] = (next_dp[current_val][current_matches] + contribution_from_different) % MOD;
            }
        }
        // Update dp to next_dp for the next iteration (next length)
        dp = next_dp;
    }

    // Calculate the final answer:
    // Sum dp[val][k] for all possible last_val (1 to m) for arrays of length n.
    let total_arrays = 0;
    for (let val = 1; val <= m; val++) {
        total_arrays = (total_arrays + dp[val][k]) % MOD;
    }

    return total_arrays;
};