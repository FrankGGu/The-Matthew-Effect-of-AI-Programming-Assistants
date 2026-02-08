impl Solution {
    pub fn number_of_arrays(s: String, k: i32) -> i32 {
        let n = s.len();
        let k_str = k.to_string();
        let k_len = k_str.len();
        let s_chars: Vec<char> = s.chars().collect();
        let mut dp = vec![0; n + 1];
        dp[n] = 1;
        let mod_val = 1_000_000_007;

        for i in (0..n).rev() {
            if s_chars[i] == '0' {
                continue;
            }
            let mut num = 0;
            for j in i..std::cmp::min(i + k_len, n) {
                num = num * 10 + (s_chars[j] as i32 - '0' as i32);
                if num > k {
                    break;
                }
                dp[i] = (dp[i] + dp[j + 1]) % mod_val;
            }
        }

        dp[0]
    }
}