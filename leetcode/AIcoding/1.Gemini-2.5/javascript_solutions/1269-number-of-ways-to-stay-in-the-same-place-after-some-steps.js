var numWays = function(steps, arrLen) {
    const MOD = 10**9 + 7;

    // The maximum index we need to consider in the DP array.
    // We cannot go beyond `arrLen - 1`.
    // Also, if we are at position `j` after `i` steps, we need at least `j` steps to return to 0.
    // So, `i + j <= steps`, which implies `j <= steps - i`.
    // Combining this with `j <= i` (cannot move faster than 1 step per turn),
    // we have `j <= Math.min(i, steps - i)`.
    // The maximum value of `Math.min(i, steps - i)` over all `i` is `Math.floor(steps / 2)`.
    // Therefore, the maximum index we ever need to store in our DP array is
    // `Math.min(arrLen - 1, Math.floor(steps / 2))`.
    const maxColumn = Math.min(arrLen - 1, Math.floor(steps / 2));

    // dp[j] represents the number of ways to be at index j after the current step.
    // prev_dp[j] represents the number of ways to be at index j after the previous step.
    let prev_dp = new Array(maxColumn + 1).fill(0);
    prev_dp[0] = 1; // At step 0, there is 1 way to be at index 0.

    for (let i = 1; i <= steps; i++) {
        let curr_dp = new Array(maxColumn + 1).fill(0);
        for (let j = 0; j <= maxColumn; j++) {
            let ways = prev_dp[j]; // Option 1: Stay at current position j

            if (j > 0) {
                ways = (ways + prev_dp[j - 1]) % MOD; // Option 2: Move from j-1 to j
            }
            if (j < maxColumn) {
                ways = (ways + prev_dp[j + 1]) % MOD; // Option 3: Move from j+1 to j
            }
            curr_dp[j] = ways;
        }
        prev_dp = curr_dp;
    }

    return prev_dp[0];
};