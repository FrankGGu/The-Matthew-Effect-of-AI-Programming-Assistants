use std::collections::HashMap;
use std::cmp::min;

impl Solution {
    pub fn find_rotate_and_press_steps(ring: String, key: String) -> i32 {
        let n = ring.len();
        let m = key.len();

        let ring_chars: Vec<char> = ring.chars().collect();
        let key_chars: Vec<char> = key.chars().collect();

        // Precompute character positions in the ring for efficient lookup
        let mut char_to_indices: HashMap<char, Vec<usize>> = HashMap::new();
        for (i, &c) in ring_chars.iter().enumerate() {
            char_to_indices.entry(c).or_insert_with(Vec::new).push(i);
        }

        // dp[k_idx][r_idx] = minimum steps to spell key[0...k_idx]
        // such that ring[r_idx] is the character pressed for key[k_idx].
        let mut dp = vec![vec![i32::MAX; n]; m];

        // Base case: k_idx = 0 (first character of key)
        let first_key_char = key_chars[0];
        if let Some(indices) = char_to_indices.get(&first_key_char) {
            for &r_idx in indices {
                // Cost to rotate from 12 o'clock (index 0) to r_idx, plus 1 for pressing the button.
                let cost = min(r_idx as i32, (n - r_idx) as i32) + 1;
                dp[0][r_idx] = cost;
            }
        }

        // Fill DP table for k_idx from 1 to m-1
        for k_idx in 1..m {
            let current_key_char = key_chars[k_idx];
            let prev_key_char = key_chars[k_idx - 1];

            // Iterate through all possible positions for the current key character
            if let Some(current_char_ring_indices) = char_to_indices.get(&current_key_char) {
                // Iterate through all possible positions for the previous key character
                if let Some(prev_char_ring_indices) = char_to_indices.get(&prev_key_char) {
                    for &curr_r_idx in current_char_ring_indices {
                        for &prev_r_idx in prev_char_ring_indices {
                            // If the previous state was reachable
                            if dp[k_idx - 1][prev_r_idx] != i32::MAX {
                                // Calculate rotation cost from prev_r_idx to curr_r_idx
                                let diff = (curr_r_idx as i32 - prev_r_idx as i32).abs();
                                let rotation_cost = min(diff, (n as i32 - diff));

                                // Total cost for this path: previous cost + rotation cost + 1 (for press)
                                let total_cost = dp[k_idx - 1][prev_r_idx] + rotation_cost + 1;

                                // Update dp table with the minimum cost
                                dp[k_idx][curr_r_idx] = min(dp[k_idx][curr_r_idx], total_cost);
                            }
                        }
                    }
                }
            }
        }

        // The final answer is the minimum cost in the last row of the DP table
        let mut min_total_steps = i32::MAX;
        for &cost in dp[m - 1].iter() {
            min_total_steps = min(min_total_steps, cost);
        }

        min_total_steps
    }
}