impl Solution {
    pub fn longest_ideal_subsequence(s: String, k: i32) -> i32 {
        let mut dp = vec![0; 26];
        let k_usize = k as usize;

        for c in s.chars() {
            let char_code = (c as u8 - b'a') as usize;
            let mut current_max = 0;

            let start_range = if char_code >= k_usize {
                char_code - k_usize
            } else {
                0
            };
            let end_range = (char_code + k_usize).min(25);

            for prev_char_code in start_range..=end_range {
                current_max = current_max.max(dp[prev_char_code]);
            }
            dp[char_code] = current_max + 1;
        }

        *dp.iter().max().unwrap_or(&0)
    }
}