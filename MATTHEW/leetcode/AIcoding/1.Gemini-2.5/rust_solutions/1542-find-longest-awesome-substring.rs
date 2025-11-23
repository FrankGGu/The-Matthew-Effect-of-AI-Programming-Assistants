use std::cmp::max;

impl Solution {
    pub fn longest_awesome(s: String) -> i32 {
        let n = s.len();
        let mut max_len = 0;
        let mut current_mask = 0;

        // `pos[mask]` stores the first index `i` such that the prefix `s[0...i]` has `mask`.
        // We initialize `pos[0] = -1` to handle cases where an awesome substring starts from index 0.
        // If `s[0...i]` itself is awesome (mask is 0 or 1 << k), its length would be `i - (-1) = i + 1`.
        let mut pos = vec![-1; 1 << 10]; // 2^10 possible masks (for digits 0-9)
        pos[0] = -1;

        for i in 0..n {
            let digit = (s.as_bytes()[i] - b'0') as usize;
            current_mask ^= (1 << digit);

            // Case 1: The substring `s[j+1 ... i]` has a mask of 0 (all digits appear an even number of times).
            // This happens if `current_mask ^ prefix_mask_at_j == 0`, meaning `prefix_mask_at_j == current_mask`.
            if pos[current_mask] != -1 {
                max_len = max(max_len, i as i32 - pos[current_mask]);
            }

            // Case 2: The substring `s[j+1 ... i]` has a mask of `(1 << k)` (exactly one digit appears an odd number of times).
            // This happens if `current_mask ^ prefix_mask_at_j == (1 << k)`, meaning `prefix_mask_at_j == current_mask ^ (1 << k)`.
            for k in 0..10 {
                let target_mask = current_mask ^ (1 << k);
                if pos[target_mask] != -1 {
                    max_len = max(max_len, i as i32 - pos[target_mask]);
                }
            }

            // Store the first occurrence of `current_mask`.
            // If `pos[current_mask]` is still -1, it means this is the first time we encounter this mask.
            if pos[current_mask] == -1 {
                pos[current_mask] = i as i32;
            }
        }

        max_len
    }
}