impl Solution {
    pub fn decode_at_index(s: String, k: i64) -> String {
        let mut decoded_len: i64 = 0;
        let s_chars: Vec<char> = s.chars().collect();

        // First pass: calculate the total length of the decoded string
        // `decoded_len` will store the length of the string formed by `s[0...i]`
        for &c in s_chars.iter() {
            if c.is_ascii_digit() {
                let digit = c.to_digit(10).unwrap() as i64;
                decoded_len *= digit;
            } else {
                decoded_len += 1;
            }
        }

        // Second pass: iterate backward through the input string `s`
        // to find the K-th character.
        let mut k_mut = k;
        for i in (0..s_chars.len()).rev() {
            let c = s_chars[i];

            // Adjust `k_mut` to be within the current segment's length.
            // This handles cases where `k_mut` falls into a repeated block.
            // If `k_mut` becomes 0 after modulo, it means it's the last character of the block.
            k_mut %= decoded_len;
            if k_mut == 0 {
                k_mut = decoded_len;
            }

            if c.is_ascii_digit() {
                let digit = c.to_digit(10).unwrap() as i64;
                // If `c` is a digit, it means the string *before* this digit was repeated `digit` times.
                // So, the length of that previous string (the base string that was repeated)
                // was `decoded_len / digit`. We update `decoded_len` to this smaller value.
                decoded_len /= digit;
            } else {
                // If `c` is a letter, it means it was simply appended.
                // If `k_mut` now matches the `decoded_len`, it means this character `c` is our target.
                if k_mut == decoded_len {
                    return c.to_string();
                }
                // If not, this character `c` is not our target.
                // We remove its contribution to the length by decrementing `decoded_len`.
                decoded_len -= 1;
            }
        }

        // This part should ideally not be reached given problem constraints
        // (s is non-empty and k is a valid index).
        unreachable!();
    }
}