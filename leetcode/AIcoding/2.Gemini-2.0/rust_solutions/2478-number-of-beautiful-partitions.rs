impl Solution {
    pub fn number_of_beautiful_partitions(s: String, k: i32, min_length: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        if (s[0] as char) != '2' && (s[0] as char) != '3' && (s[0] as char) != '5' && (s[0] as char) != '7' {
            return 0;
        }

        let mut dp = vec![0; n + 1];
        dp[n] = 1;
        let mod_val = 1_000_000_007;

        for i in (0..n).rev() {
            if (s[i] as char) != '2' && (s[i] as char) != '3' && (s[i] as char) != '5' && (s[i] as char) != '7' {
                continue;
            }
            for j in i + min_length as usize..=n {
                let sub = &s[i..j];
                if j == n || ((s[j] as char) != '2' && (s[j] as char) != '3' && (s[j] as char) != '5' && (s[j] as char) != '7') {
                    dp[i] = (dp[i] + dp[j]) % mod_val;
                }
            }
        }

        dp[0]
    }
}