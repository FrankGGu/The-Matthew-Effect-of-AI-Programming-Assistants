var minCost = function(num1, num2, cost1, cost2) {
    const n = num1.length;

    // dp[i][0] represents the minimum cost to make num1[0...i-1] equal to num2[0...i-1],
    // where num1[i-1] was NOT part of a cost2 operation that extends to num1[i].
    // dp[i][1] represents the minimum cost to make num1[0...i-1] equal to num2[0...i-1],
    // where num1[i-1] WAS part of a cost2 operation that extends to num1[i].
    const dp = Array(n + 1).fill(null).map(() => [Infinity, Infinity]);

    dp[0][0] = 0; // Base case: 0 cost to match an empty prefix, with no pending operation.

    for (let i = 0; i < n; i++) {
        const digit1 = parseInt(num1[i]);
        const digit2 = parseInt(num2[i]);
        let diff = (digit2 - digit1 + 10) % 10; // Number of increments needed for num1[i] to become num2[i]

        // Option 1: Consider transitions from dp[i][0] (no pending cost2 operation affecting num1[i])
        if (dp[i][0] !== Infinity) {
            // Sub-option 1.1: Resolve num1[i] using only cost1 operations.
            // This means num1[i] is incremented 'diff' times.
            // No cost2 operation is started at 'i', so no pending operation for num1[i+1].
            dp[i+1][0] = Math.min(dp[i+1][0], dp[i][0] + diff * cost1);

            // Sub-option 1.2: Resolve num1[i] partially using a cost2 operation on num1[i] and num1[i+1].
            // This cost2 operation increments num1[i] by 1.
            // The remaining 'diff' for num1[i] is (diff - 1 + 10) % 10.
            // This operation starts a pending cost2 operation that affects num1[i+1].
            dp[i+1][1] = Math.min(dp[i+1][1], dp[i][0] + ((diff - 1 + 10) % 10) * cost1 + cost2);
        }

        // Option 2: Consider transitions from dp[i][1] (a pending cost2 operation affected num1[i])
        if (dp[i][1] !== Infinity) {
            // The pending cost2 operation from index i-1 already incremented num1[i] by 1.
            // So, the effective difference for num1[i] is reduced by 1.
            const effectiveDiffAfterPrevCost2 = (diff - 1 + 10) % 10;

            // Sub-option 2.1: Resolve num1[i] using only cost1 operations (after the previous cost2 effect).
            // No new cost2 operation is started at 'i', so no pending operation for num1[i+1].
            dp[i+1][0] = Math.min(dp[i+1][0], dp[i][1] + effectiveDiffAfterPrevCost2 * cost1);

            // Sub-option 2.2: Resolve num1[i] partially using another cost2 operation on num1[i] and num1[i+1].
            // This new cost2 operation increments num1[i] by 1 again.
            // The remaining 'diff' for num1[i] is (effectiveDiffAfterPrevCost2 - 1 + 10) % 10.
            // This operation starts a pending cost2 operation that affects num1[i+1].
            dp[i+1][1] = Math.min(dp[i+1][1], dp[i][1] + ((effectiveDiffAfterPrevCost2 - 1 + 10) % 10) * cost1 + cost2);
        }
    }

    // The final answer must be the minimum cost to match all digits, with no pending operations at the end.
    return dp[n][0];
};