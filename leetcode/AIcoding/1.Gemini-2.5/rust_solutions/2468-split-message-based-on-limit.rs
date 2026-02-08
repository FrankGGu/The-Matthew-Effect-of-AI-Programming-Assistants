impl Solution {
    // Helper function to quickly determine the number of digits in a usize.
    // Optimized for numbers up to 1,000,000 (max n or i value is 10^5).
    fn num_digits_fast(x: usize) -> usize {
        if x < 10 {
            1
        } else if x < 100 {
            2
        } else if x < 1000 {
            3
        } else if x < 10000 {
            4
        } else if x < 100000 {
            5
        } else {
            // For x >= 100,000. Max message.length is 10^5, so max n is 10^5.
            // 100,000 has 6 digits.
            6
        }
    }

    pub fn split_message(message: String, limit: i32) -> Vec<String> {
        let msg_len = message.len();
        let limit = limit as usize;

        let mut low = 1;
        // The maximum possible number of parts `n` is `msg_len`.
        // If `n > msg_len`, it would mean on average each part contains less than one character,
        // which is not possible if each part must contain at least one character.
        // The minimum chunk length is 1, so `n` cannot exceed `msg_len`.
        let mut high = msg_len;
        let mut ans_n = 0; // Stores the smallest valid `n`

        // Binary search for the smallest `n` (total number of parts)
        while low <= high {
            let mid = low + (high - low) / 2;
            if mid == 0 { // Should not happen with low starting at 1, but as a safeguard
                low = 1;
                continue;
            }

            let len_n = Self::num_digits_fast(mid);
            let mut total_chunk_len_possible = 0;
            let mut possible = true;

            for i in 1..=mid {
                let len_i = Self::num_digits_fast(i);
                let suffix_len_i = 2 + len_i + len_n; // Length of "<i/n>"

                // If the suffix itself exceeds or equals the limit,
                // there's no space for the message chunk, so this `n` is impossible.
                if suffix_len_i >= limit {
                    possible = false;
                    break;
                }

                let chunk_len_i = limit - suffix_len_i;
                total_chunk_len_possible += chunk_len_i;

                // Optimization: If we've already accumulated enough space to fit the entire message,
                // we don't need to calculate further for this `mid`.
                if total_chunk_len_possible >= msg_len {
                    break;
                }
            }

            if possible && total_chunk_len_possible >= msg_len {
                ans_n = mid;
                high = mid - 1; // Try to find a smaller `n`
            } else {
                low = mid + 1; // Need a larger `n`
            }
        }

        // If no valid `n` was found, return an empty vector
        if ans_n == 0 {
            return vec![];
        }

        // Construct the result using the found `ans_n`
        let mut result = Vec::with_capacity(ans_n);
        let mut current_char_idx = 0;
        let len_n_final = Self::num_digits_fast(ans_n);

        for i in 1..=ans_n {
            let len_i_final = Self::num_digits_fast(i);
            let suffix_len_final = 2 + len_i_final + len_n_final;
            let chunk_len_to_take = limit - suffix_len_final;

            // Determine the actual chunk to take from the message
            let end_char_idx = (current_char_idx + chunk_len_to_take).min(msg_len);
            let chunk = &message[current_char_idx..end_char_idx];

            // Format the part and add to the result
            result.push(format!("{}{}/{}>", chunk, i, ans_n));
            current_char_idx = end_char_idx;
        }

        result
    }
}