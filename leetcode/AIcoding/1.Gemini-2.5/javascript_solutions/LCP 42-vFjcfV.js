var toyHoop = function(n, k, target) {
    // dp[i][pos][mask] represents the maximum expected number of distinct targets
    // visited in total, given i throws remaining, current position pos,
    // and mask represents the set of targets already visited.
    // i: number of throws remaining (0 to k)
    // pos: current position (0 to n-1)
    // mask: bitmask of visited targets (0 to 2^n - 1)

    // Initialize dp table with zeros.
    // dp table size: (k + 1) * n * (1 << n)
    const dp = Array(k + 1).fill(0).map(() =>
        Array(n).fill(0).map(() =>
            Array(1 << n).fill(0)
        )
    );

    // Base case: i = 0 throws remaining.
    // The expected number of distinct targets is simply the number of set bits in the mask.
    for (let pos = 0; pos < n; pos++) {
        for (let mask = 0; mask < (1 << n); mask++) {
            let count = 0;
            for (let bit = 0; bit < n; bit++) {
                if ((mask >> bit) & 1) {
                    count++;
                }
            }
            dp[0][pos][mask] = count;
        }
    }

    // Fill the dp table for i from 1 to k (number of throws remaining)
    for (let i = 1; i <= k; i++) {
        for (let pos = 0; pos < n; pos++) {
            for (let mask = 0; mask < (1 << n); mask++) {
                let maxExpectedValue = 0;

                // For each state (i, pos, mask), we choose to throw at target j
                for (let j = 0; j < n; j++) {
                    const p_hit = target[j];
                    const p_miss = 1 - target[j];

                    // Case 1: Hit target j
                    const next_pos_hit = (j + 1) % n;
                    const next_mask_hit = mask | (1 << next_pos_hit);
                    const val_if_hit = dp[i - 1][next_pos_hit][next_mask_hit];

                    // Case 2: Miss target j
                    const next_pos_miss = pos; // Stay at current position
                    const next_mask_miss = mask; // Visited mask doesn't change
                    const val_if_miss = dp[i - 1][next_pos_miss][next_mask_miss];

                    const currentChoiceExpectedValue = p_hit * val_if_hit + p_miss * val_if_miss;
                    maxExpectedValue = Math.max(maxExpectedValue, currentChoiceExpectedValue);
                }
                dp[i][pos][mask] = maxExpectedValue;
            }
        }
    }

    // The initial state is k throws remaining, current position 0,
    // and target 0 is already visited.
    // So the initial mask is (1 << 0).
    return dp[k][0][1 << 0];
};