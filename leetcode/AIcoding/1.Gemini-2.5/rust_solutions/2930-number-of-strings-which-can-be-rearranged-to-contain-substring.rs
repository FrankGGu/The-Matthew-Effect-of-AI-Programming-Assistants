impl Solution {
    pub fn string_rearrangement(n: i32) -> i32 {
        let n_usize = n as usize;
        let modulo: i64 = 1_000_000_007;

        // dp[mask][q_state] stores the number of strings for the current length.
        // mask: A 3-bit integer representing the presence of 'a', 'b', 'c'.
        //       Bit 0 (1): 'a' is present
        //       Bit 1 (2): 'b' is present
        //       Bit 2 (4): 'c' is present
        //       e.g., mask 0 (000) means no 'a', 'b', or 'c' are explicitly present.
        //             mask 7 (111) means 'a', 'b', and 'c' are all explicitly present.
        // q_state: Represents the count of '?' characters, capped at 3.
        //          0: count('?') == 0
        //          1: count('?') == 1
        //          2: count('?') == 2
        //          3: count('?') >= 3
        let mut dp = vec![vec![0i64; 4]; 8];

        // Base case: For a string of length 0 (empty string).
        // It has no 'a', 'b', 'c' (mask 0) and no '?' (q_state 0).
        dp[0][0] = 1;

        // Iterate for each character position from 0 to n-1
        for _i in 0..n_usize {
            // Create a new DP table for the next length
            let mut next_dp = vec![vec![0i64; 4]; 8];

            // Iterate through all possible previous states
            for mask in 0..8 {
                for q_state in 0..4 {
                    if dp[mask][q_state] == 0 {
                        continue; // No strings lead to this state, skip
                    }

                    // Option 1: Add 'a'
                    let new_mask_a = mask | (1 << 0); // Set 'a' bit
                    next_dp[new_mask_a][q_state] = (next_dp[new_mask_a][q_state] + dp[mask][q_state]) % modulo;

                    // Option 2: Add 'b'
                    let new_mask_b = mask | (1 << 1); // Set 'b' bit
                    next_dp[new_mask_b][q_state] = (next_dp[new_mask_b][q_state] + dp[mask][q_state]) % modulo;

                    // Option 3: Add 'c'
                    let new_mask_c = mask | (1 << 2); // Set 'c' bit
                    next_dp[new_mask_c][q_state] = (next_dp[new_mask_c][q_state] + dp[mask][q_state]) % modulo;

                    // Option 4: Add '?'
                    let new_q_state = (q_state + 1).min(3); // Increment q_state, cap at 3
                    next_dp[mask][new_q_state] = (next_dp[mask][new_q_state] + dp[mask][q_state]) % modulo;
                }
            }
            // Update dp to the new_dp for the next iteration
            dp = next_dp;
        }

        let mut total_ans: i64 = 0;

        // After processing all n characters, sum up valid states
        for mask in 0..8 {
            for q_state in 0..4 {
                if dp[mask][q_state] == 0 {
                    continue;
                }

                // Determine how many of 'a', 'b', 'c' are still needed
                let needed_a = if (mask & (1 << 0)) == 0 { 1 } else { 0 };
                let needed_b = if (mask & (1 << 1)) == 0 { 1 } else { 0 };
                let needed_c = if (mask & (1 << 2)) == 0 { 1 } else { 0 };

                let total_needed_q = needed_a + needed_b + needed_c;

                // If the number of '?'s available (q_state) is sufficient to cover
                // the needed characters, then this state contributes to the answer.
                if total_needed_q <= q_state {
                    total_ans = (total_ans + dp[mask][q_state]) % modulo;
                }
            }
        }

        total_ans as i32
    }
}