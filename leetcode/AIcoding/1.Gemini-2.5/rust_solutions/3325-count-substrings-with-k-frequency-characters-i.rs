impl Solution {
    pub fn count_substrings_with_k_frequency_characters_i(s: String, k: i32) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut total_count = 0;

        // Iterate over all possible starting positions of a substring
        for i in 0..n {
            // `counts` stores character frequencies for the current substring s[i..j]
            let mut counts = [0; 26];
            // `distinct_count` is the number of unique characters in s[i..j]
            let mut distinct_count = 0;
            // `valid_char_count` is the number of unique characters in s[i..j]
            // that appear at least `k` times
            let mut valid_char_count = 0;

            // Iterate over all possible ending positions of a substring, starting from `i`
            for j in i..n {
                let char_idx = (s_bytes[j] - b'a') as usize;

                // If this character is encountered for the first time in the current window s[i..j]
                if counts[char_idx] == 0 {
                    distinct_count += 1;
                }

                // Increment the frequency of the current character
                counts[char_idx] += 1;

                // If the frequency of this character just reached `k`,
                // it means it now satisfies the k-frequency requirement
                if counts[char_idx] == k {
                    valid_char_count += 1;
                }

                // A substring s[i..j] is valid if all its distinct characters
                // appear at least `k` times. This condition is met when
                // the number of distinct characters equals the number of distinct characters
                // that appear at least `k` times.
                if distinct_count == valid_char_count {
                    total_count += 1;
                }
            }
        }

        total_count
    }
}