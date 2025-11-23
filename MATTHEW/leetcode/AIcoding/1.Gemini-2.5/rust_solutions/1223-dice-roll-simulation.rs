impl Solution {
    pub fn die_roll_simulation(n: i32, roll_max: Vec<i32>) -> i32 {
        let n_usize = n as usize;
        let num_faces = 6;
        let modulo = 1_000_000_007;

        // dp[i][j] represents the number of sequences of length i ending with face j
        let mut dp = vec![vec![0; num_faces]; n_usize + 1];
        // sum_dp[i] represents the total number of sequences of length i
        let mut sum_dp = vec![0; n_usize + 1];

        // Base case: i = 0 (empty sequence)
        // sum_dp[0] = 1 (one empty sequence)
        sum_dp[0] = 1;

        // Base case: i = 1
        // For each face j, there is 1 sequence of length 1 ending with j.
        for j in 0..num_faces {
            dp[1][j] = 1;
            sum_dp[1] = (sum_dp[1] + dp[1][j]) % modulo;
        }

        // Fill DP table for i from 2 to n
        for i in 2..=n_usize {
            for j in 0..num_faces {
                // Initially, assume we can append face j to any sequence of length i-1.
                // So, dp[i][j] starts with the total number of sequences of length i-1.
                dp[i][j] = sum_dp[i - 1];

                // Now, subtract invalid sequences.
                // An invalid sequence is one that would end with (roll_max[j] + 1) consecutive j's.
                // Let k = roll_max[j] as usize.
                // We need to subtract sequences of length `i` that end with `k+1` consecutive `j`'s.
                // Such sequences are formed by:
                // 1. A prefix of length `i - (k + 1)`
                // 2. This prefix must NOT end with `j`
                // 3. Followed by `k + 1` occurrences of `j`

                let max_consecutive_j = roll_max[j] as usize;

                // This condition checks if `i` is long enough to potentially have `k+1` consecutive `j`'s.
                // If `i <= max_consecutive_j`, it's impossible to have `max_consecutive_j + 1` consecutive `j`'s.
                // So `dp[i][j]` remains `sum_dp[i-1]`.
                if i > max_consecutive_j {
                    // The length of the prefix before the `k+1` consecutive `j`'s is `i - (k + 1)`.
                    let prev_len = i - (max_consecutive_j + 1);

                    // The number of sequences of length `prev_len` that do NOT end with `j` is:
                    // `sum_dp[prev_len]` (total sequences of that length)
                    // minus `dp[prev_len][j]` (sequences of that length ending with j).
                    let to_subtract = (sum_dp[prev_len] - dp[prev_len][j] + modulo) % modulo;

                    dp[i][j] = (dp[i][j] - to_subtract + modulo) % modulo;
                }
            }

            // Calculate total sequences of length i by summing up dp[i][j] for all faces j
            for j in 0..num_faces {
                sum_dp[i] = (sum_dp[i] + dp[i][j]) % modulo;
            }
        }

        sum_dp[n_usize]
    }
}