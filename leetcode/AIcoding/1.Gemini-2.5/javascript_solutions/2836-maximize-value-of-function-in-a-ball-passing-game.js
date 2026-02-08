var maximizeFunctionValue = function(parent, k) {
    const n = parent.length;
    const MAX_LOG = 31; // k can be up to 10^9. log2(10^9) is approx 29.89. We need to store jumps up to 2^30. So, indices 0 to 30, which means MAX_LOG = 31.

    // dp[j][i] stores the player after 2^j passes, starting from player i.
    const dp = Array(MAX_LOG).fill(0).map(() => Array(n).fill(0));

    // Base case: dp[0][i] is the player after 2^0 = 1 pass.
    for (let i = 0; i < n; i++) {
        dp[0][i] = parent[i];
    }

    // Fill the dp table using binary lifting
    // dp[j][i] = dp[j-1][dp[j-1][i]] means taking 2^(j-1) steps, then another 2^(j-1) steps.
    for (let j = 1; j < MAX_LOG; j++) {
        for (let i = 0; i < n; i++) {
            dp[j][i] = dp[j - 1][dp[j - 1][i]];
        }
    }

    let maxVal = 0;

    // For each starting player i, calculate the end player after k passes
    // and update the maximum value.
    for (let i = 0; i < n; i++) {
        let currentPlayer = i;
        let tempK = k;

        // Use binary lifting to find the player after k passes
        // Iterate from the largest power of 2 down to 0
        for (let j = MAX_LOG - 1; j >= 0; j--) {
            // If the j-th bit of k is set, it means we need to take a jump of 2^j passes
            if ((tempK >> j) & 1) {
                currentPlayer = dp[j][currentPlayer];
            }
        }
        maxVal = Math.max(maxVal, i + currentPlayer);
    }

    return maxVal;
};