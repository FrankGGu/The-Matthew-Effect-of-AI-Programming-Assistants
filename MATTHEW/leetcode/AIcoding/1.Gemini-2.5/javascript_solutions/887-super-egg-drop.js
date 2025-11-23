var superEggDrop = function(K, N) {
    // dp[k] will store the maximum number of floors we can check with `moves` moves and `k` eggs.
    // We want to find the minimum `moves` such that dp[K] >= N.

    // dp array stores dp[moves][k] where index k represents the number of eggs.
    // dp[0] is unused or represents 0 eggs, which can cover 0 floors.
    const dp = Array(K + 1).fill(0);
    let moves = 0;

    // Loop until we can cover N floors with K eggs.
    // In each iteration, 'moves' increases by 1, and we calculate the max floors
    // that can be covered with 'moves' total drops and 'k' eggs.
    while (dp[K] < N) {
        moves++;
        // To calculate dp[moves][k], we use dp[moves-1][k-1] and dp[moves-1][k].
        // When using a single 1D array `dp` for space optimization, `dp[k]` at the start of
        // this loop represents `dp[moves-1][k]`.
        // To correctly calculate `dp[moves][k]`, we must iterate `k` from `K` down to `1`.
        // This ensures that `dp[k-1]` and `dp[k]` on the right-hand side of the
        // assignment `dp[k] = 1 + dp[k-1] + dp[k]` are still values from the
        // previous `moves-1` iteration.
        for (let k = K; k >= 1; k--) {
            // The recurrence relation is:
            // dp[m][k] = 1 (current drop)
            //            + dp[m-1][k-1] (if egg breaks, we have m-1 moves and k-1 eggs for floors below)
            //            + dp[m-1][k]   (if egg doesn't break, we have m-1 moves and k eggs for floors above)
            // In our space-optimized 1D array:
            // dp[k] (new value) = 1 + dp[k-1] (old value) + dp[k] (old value)
            dp[k] = 1 + dp[k-1] + dp[k];
        }
    }

    return moves;
};