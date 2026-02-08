var minFinishTime = function(numLaps, tires) {
    // MAX_K_CONSIDERED_DIRECTLY defines the maximum number of consecutive laps
    // for which we directly consider the precomputed cost for a single tire type.
    // For r > 1 tires, lap times grow exponentially. A lap time exceeding
    // roughly 2 * numLaps (e.g., 2 * 10^5) makes it highly suboptimal to continue
    // with that tire if an r=1 tire with f=1 is available.
    // log2(2 * 10^5) is approximately 17.6, so 18-20 consecutive laps are usually
    // sufficient to cover all relevant cases for r > 1 tires.
    const MAX_K_CONSIDERED_DIRECTLY = 20;

    // min_cost_for_k_consecutive_laps[k] stores the minimum time to complete 'k' laps
    // using *only one* tire type consecutively, without changing tires.
    const min_cost_for_k_consecutive_laps = new Array(numLaps + 1).fill(Infinity);

    let min_f_r1 = Infinity; // Stores the minimum 'f' value among all tires with r = 1.

    // Precompute min_cost_for_k_consecutive_laps for all tire types.
    for (const [f, r] of tires) {
        if (r === 1) {
            min_f_r1 = Math.min(min_f_r1, f);
        }

        let current_lap_time = f;
        let current_total_time = 0;

        for (let k = 1; k <= numLaps; k++) {
            current_total_time += current_lap_time;
            min_cost_for_k_consecutive_laps[k] = Math.min(min_cost_for_k_consecutive_laps[k], current_total_time);

            if (r === 1) {
                // For r=1, current_lap_time remains 'f', so no update needed.
                // current_total_time += f is already handled by the first line in the loop.
            } else { // r > 1
                // Prevent overflow and stop if the next lap time becomes excessively large.
                // If current_lap_time * r exceeds (2 * numLaps + 1), it's likely better
                // to switch to an r=1 tire (if available) or another tire.
                // (2 * numLaps + 1) serves as a practical upper bound for a single optimal lap time.
                if (current_lap_time > (2 * numLaps + 1) / r) {
                    break;
                }
                current_lap_time *= r;
            }

            // If the total time for 'k' consecutive laps with this tire becomes too large,
            // further laps with this tire are unlikely to be optimal.
            // Max possible total time is roughly 10^5 * 10^5 = 10^10.
            // Using 2 * 10^14 as a safe upper bound for total time.
            if (current_total_time > 2 * 10**14) { 
                break;
            }
        }
    }

    // dp[i] will store the minimum time to finish 'i' laps.
    const dp = new Array(numLaps + 1).fill(Infinity);
    dp[0] = 0; // Base case: 0 laps take 0 time.

    // min_val_for_r1_dp stores min(dp[j] - j * min_f_r1) for relevant 'j' values.
    // This is used to optimize the calculation for large 'k' values when using r=1 tires.
    let min_val_for_r1_dp = Infinity; 

    for (let i = 1; i <= numLaps; i++) {
        // Part 1: Consider finishing the last 'k' laps (where k <= MAX_K_CONSIDERED_DIRECTLY)
        // using a single tire type consecutively.
        for (let k = 1; k <= Math.min(i, MAX_K_CONSIDERED_DIRECTLY); k++) {
            if (dp[i - k] !== Infinity && min_cost_for_k_consecutive_laps[k] !== Infinity) {
                dp[i] = Math.min(dp[i], dp[i - k] + min_cost_for_k_consecutive_laps[k]);
            }
        }

        // Part 2: Consider finishing the last 'k' laps (where k > MAX_K_CONSIDERED_DIRECTLY)
        // using an r=1 tire.
        // The recurrence is dp[i] = min(dp[j] + (i-j) * min_f_r1) where j = i - k, and k > MAX_K_CONSIDERED_DIRECTLY.
        // This implies j <= i - (MAX_K_CONSIDERED_DIRECTLY + 1).
        // Rearranging, dp[i] = i * min_f_r1 + min(dp[j] - j * min_f_r1) for j <= i - (MAX_K_CONSIDERED_DIRECTLY + 1).
        // The `min(dp[j] - j * min_f_r1)` part is a prefix minimum calculation.
        if (min_f_r1 !== Infinity) {
            const j_to_consider_for_prefix_min = i - (MAX_K_CONSIDERED_DIRECTLY + 1);

            // If j_to_consider_for_prefix_min is a valid index and dp[j_to_consider_for_prefix_min] is reachable,
            // update the prefix minimum.
            if (j_to_consider_for_prefix_min >= 0 && dp[j_to_consider_for_prefix_min] !== Infinity) {
                min_val_for_r1_dp = Math.min(min_val_for_r1_dp, dp[j_to_consider_for_prefix_min] - j_to_consider_for_prefix_min * min_f_r1);
            }

            // If a valid prefix minimum exists, apply it to dp[i].
            if (min_val_for_r1_dp !== Infinity) {
                dp[i] = Math.min(dp[i], min_val_for_r1_dp + i * min_f_r1);
            }
        }
    }

    return dp[numLaps];
};