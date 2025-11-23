impl Solution {
    pub fn find_special_substring_of_length_k(s: String, k: i32) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }
        let k_usize = k as usize;
        if k_usize == 0 {
            return 0;
        }
        if k_usize > n {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();
        let mut total_special_substrings = 0;

        // --- Type 1: All characters are the same ---
        // Count substrings of length k where all characters are identical.
        let mut current_char = chars[0];
        let mut current_len = 0;
        for i in 0..n {
            if chars[i] == current_char {
                current_len += 1;
            } else {
                if current_len >= k_usize {
                    total_special_substrings += (current_len - k_usize + 1);
                }
                current_char = chars[i];
                current_len = 1;
            }
        }
        // Handle the last run
        if current_len >= k_usize {
            total_special_substrings += (current_len - k_usize + 1);
        }

        // --- Type 2: All characters are the same except for the middle one ---
        // This only applies if k is odd.
        if k_usize % 2 == 1 {
            let l = (k_usize - 1) / 2; // Number of identical characters required on each side of the middle char

            // Precompute left_counts and right_counts for consecutive identical characters
            // left_counts[i] stores the length of the run of chars[i] ending at i.
            // right_counts[i] stores the length of the run of chars[i] starting at i.
            let mut left_counts = vec![0; n];
            let mut right_counts = vec![0; n];

            left_counts[0] = 1;
            for i in 1..n {
                if chars[i] == chars[i-1] {
                    left_counts[i] = left_counts[i-1] + 1;
                } else {
                    left_counts[i] = 1;
                }
            }

            right_counts[n-1] = 1;
            for i in (0..n-1).rev() {
                if chars[i] == chars[i+1] {
                    right_counts[i] = right_counts[i+1] + 1;
                } else {
                    right_counts[i] = 1;
                }
            }

            // Iterate through potential middle characters `chars[j]`
            // A middle character `chars[j]` needs `l` characters on its left and `l` on its right.
            // So `j` can range from `l` to `n - 1 - l`.
            for j in l..=(n - 1 - l) {
                // Check if the characters immediately surrounding `chars[j]` are the same
                // AND `chars[j]` is different from them.
                if chars[j-1] == chars[j+1] && chars[j] != chars[j-1] {
                    // We need at least 'l' identical characters on each side of `chars[j]`.
                    // The number of available identical characters on the left side (ending at j-1)
                    // is `left_counts[j-1]`.
                    // The number of available identical characters on the right side (starting at j+1)
                    // is `right_counts[j+1]`.
                    let min_len_on_side = std::cmp::min(left_counts[j-1], right_counts[j+1]);

                    // If we have at least 'l' characters on both sides, this forms a special substring of length k.
                    if min_len_on_side >= l {
                        total_special_substrings += 1;
                    }
                }
            }
        }

        total_special_substrings as i32
    }
}