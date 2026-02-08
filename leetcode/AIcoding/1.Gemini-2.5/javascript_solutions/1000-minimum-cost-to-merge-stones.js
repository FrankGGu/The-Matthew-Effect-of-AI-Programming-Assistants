var mergeStones = function(stones, k) {
    const n = stones.length;

    // If it's impossible to merge all stones into one pile, return -1.
    // Each merge operation reduces the number of piles by (k - 1).
    // To go from n piles to 1 pile, we need (n - 1) reductions.
    // So, (n - 1) must be divisible by (k - 1).
    if ((n - 1) % (k - 1) !== 0) {
        return -1;
    }

    // Calculate prefix sums to quickly get sum of stones in a range.
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    // dp[i][j][piles] represents the minimum cost to merge stones from index i to j
    // into 'piles' number of piles.
    // Initialize with Infinity.
    const dp = Array(n).fill(0).map(() =>
        Array(n).fill(0).map(() =>
            Array(k + 1).fill(Infinity)
        )
    );

    // Base case: merging a single stone into 1 pile costs 0.
    for (let i = 0; i < n; i++) {
        dp[i][i][1] = 0;
    }

    // Iterate over length of the stone range.
    for (let length = 2; length <= n; length++) {
        // Iterate over starting index of the range.
        for (let i = 0; i <= n - length; i++) {
            const j = i + length - 1; // Ending index of the range.

            // Iterate over the target number of piles (m) for the current range [i, j].
            // m goes from 2 to k.
            for (let m = 2; m <= k; m++) {
                // Iterate over split point 's'.
                // To merge stones[i...j] into 'm' piles, we can split it into two parts:
                // stones[i...s] merged into 1 pile (cost dp[i][s][1])
                // stones[s+1...j] merged into (m-1) piles (cost dp[s+1][j][m-1])
                // The split point 's' must be such that stones[i...s] can form 1 pile.
                // This implies (s - i) must be a multiple of (k - 1).
                for (let s = i; s < j; s += (k - 1)) {
                    if (dp[i][s][1] !== Infinity && dp[s + 1][j][m - 1] !== Infinity) {
                        dp[i][j][m] = Math.min(dp[i][j][m], dp[i][s][1] + dp[s + 1][j][m - 1]);
                    }
                }
            }

            // After calculating dp[i][j][m] for m=2..k,
            // now consider merging stones[i...j] into 1 pile.
            // This is only possible if the current number of stones (length)
            // can be reduced to 1 pile.
            // This means (length - 1) must be divisible by (k - 1).
            if ((length - 1) % (k - 1) === 0) {
                // To get 1 pile from stones[i...j], we must first merge them into 'k' piles,
                // and then merge those 'k' piles.
                // The cost of the final merge is the sum of stones in the range.
                if (dp[i][j][k] !== Infinity) {
                    dp[i][j][1] = dp[i][j][k] + (prefixSum[j + 1] - prefixSum[i]);
                }
            }
        }
    }

    // The final answer is the minimum cost to merge all stones (0 to n-1) into 1 pile.
    const result = dp[0][n - 1][1];
    return result === Infinity ? -1 : result;
};