struct Solution;

impl Solution {
    pub fn count_unique_good_subsequences(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mod_val = 1_000_000_007;

        let mut total_unique_good_subsequences = 0;

        let count_unique_subsequences_in_middle = |slice: &[u8]| -> i32 {
            let slice_len = slice.len();
            let mut dp = vec![0; slice_len + 1];
            dp[0] = 1;

            let mut last_occurrence: [i32; 10] = [-1; 10];

            for i in 0..slice_len {
                let current_char_digit = (slice[i] - b'0') as usize;

                dp[i + 1] = (2 * dp[i]) % mod_val;

                if last_occurrence[current_char_digit] != -1 {
                    let prev_idx_in_slice = last_occurrence[current_char_digit] as usize;
                    dp[i + 1] = (dp[i + 1] - dp[prev_idx_in_slice] + mod_val) % mod_val;
                }

                last_occurrence[current_char_digit] = i as i32;
            }
            dp[slice_len]
        };

        for d_digit in 0..10 {
            let d_char = (b'0' + d_digit as u8);

            let mut first_idx = None;
            let mut last_idx = None;

            for i in 0..n {
                if s_bytes[i] == d_char {
                    if first_idx.is_none() {
                        first_idx = Some(i);
                    }
                    last_idx = Some(i);
                }
            }

            if let Some(f_idx) = first_idx {
                let l_idx = last_idx.unwrap();

                total_unique_good_subsequences = (total_unique_good_subsequences + 1) % mod_val;

                if f_idx < l_idx {
                    let middle_slice = &s_bytes[f_idx + 1 .. l_idx];
                    let num_unique_middle_subsequences = count_unique_subsequences_in_middle(middle_slice);

                    total_unique_good_subsequences = (total_unique_good_subsequences + num_unique_middle_subsequences) % mod_val;
                }
            }
        }

        total_unique_good_subsequences
    }
}