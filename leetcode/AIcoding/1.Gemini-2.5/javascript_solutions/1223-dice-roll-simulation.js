var dieSimulator = function(n, rollMax) {
    const MOD = 10**9 + 7;

    // dp[i][j] represents the number of distinct sequences of length i ending with face j.
    // Faces are 0-indexed (0 to 5).
    const dp = Array(n + 1).fill(0).map(() => Array(6).fill(0));

    // total_sequences[i] represents the total number of distinct sequences of length i.
    const total_sequences = Array(n + 1).fill(0);

    // Base case: For length 0, there is one empty sequence.
    // This is used when calculating sequences that are exactly (rollMax[j] + 1) consecutive j's.
    total_sequences[0] = 1; 
    // dp[0][j] remains 0, as an empty sequence does not end with any face.

    // For length 1, each face can appear once.
    for (let j = 0; j < 6; j++) {
        dp[1][j] = 1;
    }
    // Total sequences of length 1 is 6 (one for each face).
    total_sequences[1] = 6;

    // Fill DP table for lengths from 2 to n
    for (let i = 2; i <= n; i++) {
        for (let j = 0; j < 6; j++) {
            // Start with the total number of sequences of length i-1.
            // If there were no rollMax constraints, we could append 'j' to any of them.
            dp[i][j] = total_sequences[i-1];

            // Now, subtract the invalid sequences.
            // An invalid sequence of length i ending with face 'j' is one that has
            // (rollMax[j] + 1) consecutive 'j's at the end.
            // Such a sequence looks like: [prefix] [j]...[j] (where 'j' is repeated rollMax[j] + 1 times).
            // The [prefix] has length `i - (rollMax[j] + 1)`.
            // Crucially, this [prefix] must NOT end with 'j' for the (rollMax[j] + 1) consecutive 'j's
            // to be formed by appending 'j's to a sequence that *didn't* end with 'j' before the block started.

            const prev_len_for_subtraction = i - (rollMax[j] + 1);

            if (prev_len_for_subtraction >= 0) {
                // The number of sequences of length `prev_len_for_subtraction` that do NOT end with 'j' is:
                // total_sequences[prev_len_for_subtraction] - dp[prev_len_for_subtraction][j].
                // This correctly handles the case where prev_len_for_subtraction is 0:
                // total_sequences[0] = 1 (empty sequence) and dp[0][j] = 0.
                // So, (1 - 0) = 1, which represents the single sequence consisting of only 'j' repeated (rollMax[j] + 1) times.
                const subtracted_val = (total_sequences[prev_len_for_subtraction] - dp[prev_len_for_subtraction][j] + MOD) % MOD;
                dp[i][j] = (dp[i][j] - subtracted_val + MOD) % MOD;
            }
            dp[i][j] %= MOD;
        }

        // Calculate total sequences for current length i by summing up dp[i][j] for all faces j.
        for (let j = 0; j < 6; j++) {
            total_sequences[i] = (total_sequences[i] + dp[i][j]) % MOD;
        }
    }

    // The final answer is the total number of distinct sequences of length n.
    return total_sequences[n];
};