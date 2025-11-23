impl Solution {
    pub fn minimum_time_to_revert_word(word: String, k: i32) -> i32 {
        let n = word.len();
        let k_usize = k as usize;

        if n == 0 {
            return 0;
        }

        // Helper function to compute the Z-array for a given slice of bytes.
        // z[i] is the length of the longest common prefix between s and s[i..].
        let calculate_z_array = |s_bytes: &[u8]| -> Vec<usize> {
            let len = s_bytes.len();
            let mut z = vec![0; len];
            if len == 0 {
                return z;
            }
            z[0] = len;

            let mut l = 0; // Left bound of the Z-box
            let mut r = 0; // Right bound of the Z-box
            for i in 1..len {
                if i <= r {
                    z[i] = std::cmp::min(r - i + 1, z[i - l]);
                }
                while i + z[i] < len && s_bytes[z[i]] == s_bytes[i + z[i]] {
                    z[i] += 1;
                }
                if i + z[i] - 1 > r {
                    l = i;
                    r = i + z[i] - 1;
                }
            }
            z
        };

        let word_bytes = word.as_bytes();

        // Construct the combined string for Z-algorithm: `word + '#' + (word + word)`
        // This allows us to find occurrences of `word` (the pattern) within `word + word` (the text).
        // The '#' character acts as a unique separator to prevent matches across the original `word` boundary.
        let mut combined_string_vec = Vec::with_capacity(n + 1 + 2 * n);
        combined_string_vec.extend_from_slice(word_bytes);
        combined_string_vec.push(b'$'); // A character not expected in 'word'
        combined_string_vec.extend_from_slice(word_bytes);
        combined_string_vec.extend_from_slice(word_bytes);

        let z_array = calculate_z_array(&combined_string_vec);

        // Iterate through the number of operations 't'
        // The maximum 't' can be 'n' (e.g., for "abcde", k=1, it takes 5 operations).
        for t in 1..=n {
            // After 't' operations, the word is effectively rotated left by 't * k' positions.
            // We only care about the rotation modulo 'n' (the length of the word).
            let effective_shift = (t * k_usize) % n;

            // We need to check if the original 'word' is equal to 'word' rotated by 'effective_shift'.
            // This is equivalent to checking if `word == (word+word)[effective_shift .. effective_shift + n]`.
            // In the `combined_string_vec = word + '#' + (word+word)`,
            // the `(word+word)` part starts at index `n + 1`.
            // So, to check if `word` matches `(word+word)[effective_shift .. effective_shift + n]`,
            // we look at the Z-value at index `n + 1 + effective_shift` in the `z_array`.
            // If `z_array[n + 1 + effective_shift]` equals `n` (the length of `word`),
            // it means `word` is found starting at that position in `combined_string_vec`,
            // which corresponds to `word` rotated by `effective_shift` being equal to the original `word`.
            let z_idx = n + 1 + effective_shift;

            if z_array[z_idx] == n {
                return t as i32;
            }
        }

        // This line should theoretically be unreachable because a string always returns
        // to its initial state after 'n' rotations (or fewer if it's periodic).
        unreachable!("A match should always be found within 'n' operations.");
    }
}