var minimumCoins = function(prices) {
    const n = prices.length;

    // dp[i][j] represents the minimum cost to cover fruits from index `i` to `n-1`,
    // where `j` is the number of free fruits available from a previous purchase
    // that can cover fruit `i` or subsequent fruits.
    // `j` can be 0, 1, or 2.
    // j=0: Fruit `i` is not free. We must buy fruit `i`.
    // j=1: Fruit `i` is free.
    // j=2: Fruit `i` and `i+1` are free.

    // The DP table needs `n` rows for fruits 0 to n-1, plus 3 extra rows for base cases (n, n+1, n+2).
    // Each row has 3 columns for the `j` states (0, 1, 2).
    const dp = Array(n + 3).fill(0).map(() => Array(3).fill(0));

    // Base cases: If `i >= n`, all fruits are considered covered, so the cost is 0.
    // dp[n][j] = 0 for j = 0, 1, 2
    // dp[n+1][j] = 0 for j = 0, 1, 2
    // dp[n+2][j] = 0 for j = 0, 1, 2
    // These are already initialized to 0 by the `Array.fill(0)` call.

    // Iterate backwards from the last fruit to the first fruit.
    for (let i = n - 1; i >= 0; i--) {
        // Iterate through the possible `j` states (number of free fruits available).
        for (let j = 0; j < 3; j++) {
            if (j > 0) {
                // Case 1: Fruit `i` is free (because `j > 0`).
                // We don't need to buy fruit `i`. We consume one free fruit.
                // The cost is simply the minimum cost to cover fruits from `i+1` onwards,
                // with `j-1` free fruits remaining.
                dp[i][j] = dp[i + 1][j - 1];
            } else {
                // Case 2: Fruit `i` is not free (because `j == 0`).
                // We must buy fruit `i`.
                // The cost includes `prices[i]`.
                // After buying fruit `i`, fruits `i+1` and `i+2` become free.
                // So, when we move to consider fruit `i+1`, we will have 2 free fruits available.
                dp[i][j] = prices[i] + dp[i + 1][2];
            }
        }
    }

    // The final answer is the minimum cost to cover fruits from index 0 to n-1,
    // starting with 0 free fruits (since no fruits have been bought yet).
    return dp[0][0];
};