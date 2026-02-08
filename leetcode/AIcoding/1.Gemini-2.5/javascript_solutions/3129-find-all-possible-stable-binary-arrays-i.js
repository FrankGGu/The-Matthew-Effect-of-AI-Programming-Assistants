var numberOfStableArrays = function(zero, one, limit) {
    const MOD = 10 ** 9 + 7;

    // dp[i][j][0] stores the number of stable arrays with i zeros and j ones, ending with '0'.
    // dp[i][j][1] stores the number of stable arrays with i zeros and j ones, ending with '1'.
    const dp = Array.from({ length: zero + 1 }, () =>
        Array.from({ length: one + 1 }, () => [0, 0])
    );

    // Base cases: Arrays consisting of only zeros or only ones.
    // An array of 'k' zeros is stable if k <= limit.
    // An array of 'k' ones is stable if k <= limit.
    for (let k = 1; k <= limit; k++) {
        if (k <= zero) {
            dp[k][0][0] = 1; // Array "0", "00", ..., up to 'limit' zeros
        }
        if (k <= one) {
            dp[0][k][1] = 1; // Array "1", "11", ..., up to 'limit' ones
        }
    }

    // Fill the DP table
    for (let i = 0; i <= zero; i++) {
        for (let j = 0; j <= one; j++) {
            // Skip (0,0) as it represents an empty array, which is handled by base cases or not counted.
            // Also, skip if both i and j are 0, as dp[0][0][0] and dp[0][0][1] are 0.
            if (i === 0 && j === 0) {
                continue;
            }

            // Calculate dp[i][j][0] (ending with '0')
            // This means we are appending a block of 'k' zeros (1 <= k <= limit)
            // to an array that had (i-k) zeros and j ones, and ended with '1'.
            if (i > 0) { // Only possible if there's at least one zero
                for (let k = 1; k <= limit; k++) {
                    if (i - k >= 0) {
                        dp[i][j][0] = (dp[i][j][0] + dp[i - k][j][1]) % MOD;
                    }
                }
            }

            // Calculate dp[i][j][1] (ending with '1')
            // This means we are appending a block of 'k' ones (1 <= k <= limit)
            // to an array that had i zeros and (j-k) ones, and ended with '0'.
            if (j > 0) { // Only possible if there's at least one one
                for (let k = 1; k <= limit; k++) {
                    if (j - k >= 0) {
                        dp[i][j][1] = (dp[i][j][1] + dp[i][j - k][0]) % MOD;
                    }
                }
            }
        }
    }

    // The total number of stable arrays is the sum of arrays ending with '0' and arrays ending with '1'.
    return (dp[zero][one][0] + dp[zero][one][1]) % MOD;
};