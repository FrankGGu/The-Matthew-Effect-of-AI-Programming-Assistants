impl Solution {
    pub fn find_substring_in_wrapround_string(p: String) -> i32 {
        let mut dp = [0; 26];
        let mut max_len = 0;

        for (i, c) in p.chars().enumerate() {
            let idx = (c as u8 - b'a') as usize;
            if i > 0 && (p.chars().nth(i - 1).unwrap() as u8 + 1) % 26 == c as u8 % 26 {
                max_len += 1;
            } else {
                max_len = 1;
            }
            dp[idx] = dp[idx].max(max_len);
        }

        dp.iter().sum()
    }
}