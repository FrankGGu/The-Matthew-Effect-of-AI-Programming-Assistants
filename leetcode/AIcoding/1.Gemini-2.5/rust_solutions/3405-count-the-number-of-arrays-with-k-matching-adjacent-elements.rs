impl Solution {
    pub fn count_arrays(n: i32, m: i32, k: i32) -> i32 {
        let n_usize = n as usize;
        let m_usize = m as usize;
        let k_usize = k as usize;
        let mod_val = 1_000_000_007;

        // dp[k_val][last_val] stores the number of arrays of current length
        // with k_val matching adjacent elements, ending with last_val.
        // We only need the previous row to compute the current row, so we use two arrays.
        let mut prev_dp: Vec<Vec<i32>> = vec![vec![0; m_usize + 1]; k_usize + 1];
        let mut curr_dp: Vec<Vec<i32>> = vec![vec![0; m_usize + 1]; k_usize + 1];

        // Base case: arrays of length 1
        // An array of length 1 has 0 matching adjacent elements.
        // For each possible last_val (1 to m), there's 1 way to form such an array.
        for j in 1..=m_usize {
            prev_dp[0][j] = 1;
        }

        // Build arrays from length 2 up to n
        for _i in 2..=n_usize {
            // Clear curr_dp for the current length
            for row in curr_dp.iter_mut() {
                for x in row.iter_mut() {
                    *x = 0;
                }
            }

            // Calculate sum of prev_dp[k_val][j] for all j, for each k_val.
            // This sum is used to efficiently calculate ways where the previous element is different.
            let mut sum_prev_dp_for_k_val: Vec<i32> = vec![0; k_usize + 1];
            for k_val in 0..=k_usize {
                for j in 1..=m_usize {
                    sum_prev_dp_for_k_val[k_val] = (sum_prev_dp_for_k_val[k_val] + prev_dp[k_val][j]) % mod_val;
                }
            }

            // Fill curr_dp for the current length
            for k_val in 0..=k_usize {
                for j in 1..=m_usize {
                    // Case 1: The current element `j` matches the previous element `j`.
                    // This means we need `k_val - 1` matches from the previous `_i-1` elements,
                    // and the previous element must have been `j`.
                    if k_val > 0 {
                        curr_dp[k_val][j] = (curr_dp[k_val][j] + prev_dp[k_val - 1][j]) % mod_val;
                    }

                    // Case 2: The current element `j` does NOT match the previous element.
                    // This means we need `k_val` matches from the previous `_i-1` elements,
                    // and the previous element must NOT have been `j`.
                    // We use the pre-calculated sum and subtract the case where the previous element was `j`.
                    let ways_from_diff_prev = (sum_prev_dp_for_k_val[k_val] - prev_dp[k_val][j] + mod_val) % mod_val;
                    curr_dp[k_val][j] = (curr_dp[k_val][j] + ways_from_diff_prev) % mod_val;
                }
            }
            // Swap prev_dp and curr_dp to prepare for the next length
            std::mem::swap(&mut prev_dp, &mut curr_dp);
        }

        // After iterating through all lengths up to n, prev_dp holds the results for length n.
        // Sum up all ways for exactly `k_usize` matches across all possible last elements.
        let mut total_arrays = 0;
        for j in 1..=m_usize {
            total_arrays = (total_arrays + prev_dp[k_usize][j]) % mod_val;
        }

        total_arrays
    }
}