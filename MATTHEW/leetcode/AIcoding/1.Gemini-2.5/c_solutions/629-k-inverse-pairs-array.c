int kInversePairs(int n, int k) {
    long long dp[k + 1]; 
    const int MOD = 1000000007;

    // Initialize dp table. dp[j] will store the number of arrays with 'i' elements
    // and 'j' inverse pairs.
    // Base case: For i=0 (0 elements), there is 1 way to have 0 inverse pairs (empty array).
    // All other counts for j > 0 are 0.
    for (int j = 0; j <= k; ++j) {
        dp[j] = 0;
    }
    dp[0] = 1;

    // Iterate for 'i' from 1 to n (number of elements)
    for (int i = 1; i <= n; ++i) {
        // For each 'i', we compute the dp values for 'j' inverse pairs.
        // The recurrence relation used here is:
        // dp[i][j] = dp[i][j-1] + dp[i-1][j] - dp[i-1][j-i]
        // When using space optimization (single dp array):
        // dp[j] (new) = (dp[j-1] (new) + dp[j] (old)) % MOD
        // If j >= i, then dp[j] (new) = (dp[j] (new) - dp[j-i] (old) + MOD) % MOD
        // Note that dp[0] (for 0 inverse pairs) will always be 1, as there's only
        // one way to have 0 inverse pairs (the sorted array 1, 2, ..., i).
        // So, we start 'j' from 1.
        for (int j = 1; j <= k; ++j) {
            // Add dp[i][j-1] (which is current dp[j-1] in the single array)
            // and dp[i-1][j] (which is previous dp[j] in the single array)
            dp[j] = (dp[j-1] + dp[j]) % MOD;

            // If j >= i, subtract dp[i-1][j-i] (which is previous dp[j-i] in the single array)
            if (j >= i) {
                dp[j] = (dp[j] - dp[j-i] + MOD) % MOD;
            }
        }
    }

    return (int)dp[k];
}