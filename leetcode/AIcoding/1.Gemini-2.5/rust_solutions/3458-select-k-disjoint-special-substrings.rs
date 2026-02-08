impl Solution {
    pub fn select_k_disjoint_special_substrings(s: String, k: i32) -> i32 {
        let n = s.len();
        let k = k as usize;

        // dp[i][j] will store the maximum total length of j disjoint special substrings
        // considering the prefix s[0...i-1].
        // Size: (n + 1) x (k + 1)
        let mut dp = vec![vec![0; k + 1]; n + 1];

        // Compute prefix_balance array.
        // prefix_balance[x] stores the balance (count of '1's - count of '0's)
        // for the prefix s[0...x-1].
        // prefix_balance[0] is 0 (for an empty prefix).
        let mut prefix_balance = vec![0; n + 1];
        for i in 0..n {
            let val = if s.chars().nth(i).unwrap() == '1' { 1 } else { -1 };
            prefix_balance[i + 1] = prefix_balance[i] + val;
        }

        // Iterate through the number of substrings (j)
        for j in 1..=k {
            // max_val_for_balance[pb_val + n] stores max(dp[p][j-1] - p)
            // for all p such that prefix_balance[p] == pb_val.
            // We add 'n' to the balance value to map it to a non-negative array index.
            // Initialize with a very small number to represent unreachable states.
            let mut max_val_for_balance = vec![i32::MIN / 2; 2 * n + 1];

            // Base case for p=0:
            // dp[0][j-1] is 0 (max length of j-1 substrings from an empty string).
            // So, dp[0][j-1] - 0 = 0.
            // This is for prefix_balance[0], which is 0.
            max_val_for_balance[(prefix_balance[0] + n as i32) as usize] = dp[0][j-1] - 0;

            // Iterate through the end index (exclusive) of the current prefix s[0...i-1]
            for i in 1..=n {
                // Option 1: Do not include any special substring ending at index i-1.
                // In this case, the result is the same as considering s[0...i-2].
                dp[i][j] = dp[i-1][j];

                // Option 2: Include a special substring s[p...i-1] ending at index i-1.
                // This substring has length (i - p).
                // It must be special, meaning prefix_balance[i] == prefix_balance[p].
                // The remaining j-1 substrings must come from s[0...p-1], with max length dp[p][j-1].
                // We want to maximize (dp[p][j-1] + (i - p)) for valid p.
                // This is equivalent to maximizing (dp[p][j-1] - p) + i.
                // The max(dp[p][j-1] - p) is retrieved from max_val_for_balance using prefix_balance[i].
                let current_pb = prefix_balance[i];
                let pb_idx = (current_pb + n as i32) as usize; // Map balance value to array index

                if max_val_for_balance[pb_idx] != i32::MIN / 2 { // Check if a valid 'p' exists for this balance
                    dp[i][j] = dp[i][j].max(max_val_for_balance[pb_idx] + i as i32);
                }

                // Update max_val_for_balance for the current `i`.
                // `dp[i][j-1]` represents the max length of `j-1` substrings from `s[0...i-1]`.
                // So, `dp[i][j-1] - i` is a candidate value for `max_val_for_balance`
                // associated with `prefix_balance[i]`.
                let current_candidate = dp[i][j-1] - i as i32;
                max_val_for_balance[pb_idx] = max_val_for_balance[pb_idx].max(current_candidate);
            }
        }

        dp[n][k]
    }
}