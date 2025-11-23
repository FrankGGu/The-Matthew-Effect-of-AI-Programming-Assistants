var stoneGameII = function(piles) {
    const n = piles.length;

    // suffixSum[i] stores the sum of piles from index i to n-1
    // suffixSum[n] will be 0.
    const suffixSum = new Array(n + 1).fill(0);
    for (let i = n - 1; i >= 0; i--) {
        suffixSum[i] = suffixSum[i + 1] + piles[i];
    }

    // dp[i][m] stores the maximum number of stones the current player can get
    // from piles[i:] given that the current M value is m.
    // i ranges from 0 to n, m ranges from 1 to n.
    const dp = Array(n + 1).fill(0).map(() => Array(n + 1).fill(0));

    // Iterate i from n-1 down to 0 (representing the starting index of remaining piles)
    for (let i = n - 1; i >= 0; i--) {
        // Iterate m from 1 up to n (representing the current M value)
        for (let m = 1; m <= n; m++) {
            // If the current player can take all remaining piles (i.e., 2*m is greater than or equal to the number of remaining piles)
            // they will take all of them.
            if (i + 2 * m >= n) {
                dp[i][m] = suffixSum[i];
            } else {
                // Otherwise, the current player tries to maximize their score
                // by taking x piles (where 1 <= x <= 2*m).
                let maxStones = 0;
                for (let x = 1; x <= 2 * m; x++) {
                    // The current player takes x piles.
                    // Stones taken by current player in this turn: piles[i] + ... + piles[i+x-1]
                    // This is equivalent to suffixSum[i] - suffixSum[i+x].
                    //
                    // After taking x piles, the remaining piles start from index i+x.
                    // The new M value for the next player (opponent) will be Math.max(m, x).
                    // The opponent will then play optimally from piles[i+x:] and get dp[i+x][Math.max(m, x)] stones.
                    //
                    // The total stones available from piles[i+x:] is suffixSum[i+x].
                    // So, the stones the current player gets from the remaining piles (that the opponent doesn't take)
                    // is suffixSum[i+x] - dp[i+x][Math.max(m, x)].
                    //
                    // Total stones for the current player for this choice of x:
                    // (suffixSum[i] - suffixSum[i+x]) + (suffixSum[i+x] - dp[i+x][Math.max(m, x)])
                    // This simplifies to: suffixSum[i] - dp[i+x][Math.max(m, x)]

                    // The condition i + x <= n ensures we don't access dp[index > n] or suffixSum[index > n]
                    // (suffixSum[n] and dp[n][m] are base cases initialized to 0).
                    if (i + x <= n) { 
                        maxStones = Math.max(maxStones, suffixSum[i] - dp[i + x][Math.max(m, x)]);
                    }
                }
                dp[i][m] = maxStones;
            }
        }
    }

    // The game starts with Alice at index 0 and M = 1.
    return dp[0][1];
};