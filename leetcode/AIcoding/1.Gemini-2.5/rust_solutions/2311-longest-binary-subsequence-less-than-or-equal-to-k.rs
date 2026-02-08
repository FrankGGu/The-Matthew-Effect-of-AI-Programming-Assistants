impl Solution {
    pub fn longest_binary_subsequence(s: String, k: i32) -> i32 {
        let mut current_value: u64 = 0;
        let mut current_length: usize = 0;
        let k_u64 = k as u64;

        for c in s.chars().rev() {
            if c == '0' {
                current_length += 1;
            } else { // c == '1'
                // Check if adding this '1' (at its current positional value)
                // would exceed k.
                // current_length represents the power of 2 for the current bit (0-indexed from right).
                // Example: if current_length is 0, it's 2^0. If 1, it's 2^1.
                // The `current_length < 63` check prevents `1u64 << current_length` from overflowing
                // if `current_length` were 64 or more.
                // However, given `k`'s max value (2^31 - 1), `current_length` for '1's will not
                // exceed 30, so this check is mostly for robustness.
                if current_length < 63 && current_value + (1u64 << current_length) <= k_u64 {
                    current_value += 1u64 << current_length;
                    current_length += 1;
                }
            }
        }

        current_length as i32
    }
}