var numberOfStableArrays = function(zero, one, limit) {
    const MOD = 10**9 + 7;

    // dp[i][j][0] = number of stable arrays with i zeros and j ones, ending with a 0
    // dp[i][j][1] = number of stable arrays with i zeros and j ones, ending with a 1
    const dp = Array(zero + 1).fill(0).map(() => 
                 Array(one + 1).fill(0).map(() => Array(2).fill(0)));

    // sum0[i][j] = sum of dp[i][k][0] for k from 0 to j
    // This helps calculate dp[i][j][1] efficiently (sum of previous states ending with 0)
    const sum0 = Array(zero + 1).fill(0).map(() => Array(one + 1).fill(0));

    // sum1[i][j] = sum of dp[k][j][1] for k from 0 to i
    // This helps calculate dp[i][j][0] efficiently (sum of previous states ending with 1)
    const sum1 = Array(zero + 1).fill(0).map(() => Array(one + 1).fill(0));

    // Initialize base cases for dp: arrays consisting only of zeros or only of ones
    // An array of `k` zeros is stable if k <= limit (e.g., "0", "00" if limit >= 2)
    // An array of `k` ones is stable if k <= limit (e.g., "1", "11" if limit >= 2)
    for (let k = 1; k <= limit; k++) {
        if (k <= zero) {
            dp[k][0][0] = 1; 
        }
        if (k <= one) {
            dp[0][k][1] = 1; 
        }
    }

    // Initialize prefix sums for the first row (i=0) and first column (j=0)
    // For j=0 column (arrays with only zeros)
    for (let i = 0; i <= zero; i++) {
        sum0[i][0] = dp[i][0][0]; // dp[i][0][0] is 1 if i <= limit, else 0
        // dp[i][0][1] is always 0, so sum1[i][0] remains 0
    }

    // For i=0 row (arrays with only ones)
    for (let j = 0; j <= one; j++) {
        sum1[0][j] = dp[0][j][1]; // dp[0][j][1] is 1 if j <= limit, else 0
        // dp[0][j][0] is always 0, so sum0[0][j] remains 0
    }

    // Fill the DP table for mixed arrays (i > 0 and j > 0)
    for (let i = 1; i <= zero; i++) {
        for (let j = 1; j <= one; j++) {
            // Calculate dp[i][j][0] (number of stable arrays with i zeros and j ones, ending with 0)
            // This means we are appending a block of 0s. The previous part must have ended with a 1.
            // The number of trailing zeros can be from 1 to `limit`.
            // This is equivalent to summing dp[x][j][1] for x from i-limit to i-1.
            // This sum is efficiently calculated using `sum1` prefix sums.
            let val0 = sum1[i-1][j];
            if (i - limit - 1 >= 0) {
                val0 = (val0 - sum1[i - limit - 1][j] + MOD) % MOD;
            }
            dp[i][j][0] = val0;

            // Calculate dp[i][j][1] (number of stable arrays with i zeros and j ones, ending with 1)
            // This means we are appending a block of 1s. The previous part must have ended with a 0.
            // The number of trailing ones can be from 1 to `limit`.
            // This is equivalent to summing dp[i][y][0] for y from j-limit to j-1.
            // This sum is efficiently calculated using `sum0` prefix sums.
            let val1 = sum0[i][j-1];
            if (j - limit - 1 >= 0) {
                val1 = (val1 - sum0[i][j - limit - 1] + MOD) % MOD;
            }
            dp[i][j][1] = val1;

            // Update prefix sums for current (i, j) for subsequent calculations
            sum0[i][j] = (sum0[i][j-1] + dp[i][j][0]) % MOD;
            sum1[i][j] = (sum1[i-1][j] + dp[i][j][1]) % MOD;
        }
    }

    // The total number of stable arrays with `zero` zeros and `one` ones
    // is the sum of those ending with 0 and those ending with 1.
    return (dp[zero][one][0] + dp[zero][one][1]) % MOD;
};