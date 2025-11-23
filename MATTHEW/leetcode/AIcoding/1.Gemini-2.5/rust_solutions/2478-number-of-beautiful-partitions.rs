impl Solution {
    fn is_vowel(c: char) -> bool {
        c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
    }

    fn is_consonant(c: char) -> bool {
        !Self::is_vowel(c)
    }

    pub fn beautiful_partitions(s: String, k: i32, min_length: i32) -> i32 {
        let n = s.len();
        let k = k as usize;
        let min_length = min_length as usize;

        if k == 0 {
            return if n == 0 { 1 } else { 0 };
        }
        if n == 0 {
            return 0;
        }

        let s_chars: Vec<char> = s.chars().collect();

        if !Self::is_vowel(s_chars[0]) || !Self::is_consonant(s_chars[n - 1]) {
            return 0;
        }

        if k * min_length > n {
            return 0;
        }

        let mod_val: i32 = 1_000_000_007;
        let mut dp = vec![vec![0; k + 1]; n + 1];

        dp[n][0] = 1;

        for i in (0..n).rev() {
            if Self::is_consonant(s_chars[i]) {
                continue;
            }

            for j in 1..=k {
                for p in i + min_length - 1..n {
                    if Self::is_consonant(s_chars[p]) {
                        dp[i][j] = (dp[i][j] + dp[p + 1][j - 1]) % mod_val;
                    }
                }
            }
        }

        dp[0][k]
    }
}