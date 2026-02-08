var numPermsDISequence = function(S) {
    const n = S.length;
    const MOD = 10**9 + 7;

    // dp[j] represents the number of valid permutations of 0...i
    // such that the (i+1)-th element (at index i) is j.
    // We use a single array 'dp' to store results for 'i-1'
    // and 'new_dp' to store results for 'i'.
    let dp = new Array(n + 1).fill(0);
    dp[0] = 1; // Base case: For i=0, permutation is [0], ending with 0.

    for (let i = 1; i <= n; i++) {
        let new_dp = new Array(n + 1).fill(0); // For current length i

        if (S[i - 1] === 'I') {
            // S[i-1] == 'I' means P[i-1] < P[i]
            // P[i] is j. We need P[i-1] to be some k < j.
            // dp[i][j] = sum(dp[i-1][k] for k < j)
            let prefix_sum = 0;
            for (let j = 0; j <= i; j++) {
                new_dp[j] = prefix_sum;
                // dp[j] here refers to dp[i-1][j]
                prefix_sum = (prefix_sum + dp[j]) % MOD;
            }
        } else { // S[i-1] === 'D'
            // S[i-1] == 'D' means P[i-1] > P[i]
            // P[i] is j. We need P[i-1] to be some k > j.
            // dp[i][j] = sum(dp[i-1][k] for k >= j)
            let suffix_sum = 0;
            for (let j = i; j >= 0; j--) {
                // dp[j] here refers to dp[i-1][j]
                suffix_sum = (suffix_sum + dp[j]) % MOD;
                new_dp[j] = suffix_sum;
            }
        }
        dp = new_dp; // Update dp to be the new_dp for the next iteration
    }

    // The final answer is the sum of all dp[n][j] for j from 0 to n.
    let total_permutations = 0;
    for (let j = 0; j <= n; j++) {
        total_permutations = (total_permutations + dp[j]) % MOD;
    }

    return total_permutations;
};