impl Solution {
    pub fn beautiful_partitions(s: String, k: i32, min_length: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let n = s.len();
        let s = s.chars().collect::<Vec<_>>();

        if s[0] == '0' || s[n - 1] == '0' || k == 0 {
            return 0;
        }

        let mut dp = vec![vec![0; k as usize + 1]; n + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 1..=k {
                if i >= min_length as usize {
                    let mut count = 0;
                    for l in (i - min_length as usize)..=i {
                        if s[l - 1] == '1' {
                            count = (count + dp[l - min_length as usize][j - 1]) % mod_val;
                        }
                    }
                    dp[i][j] = (dp[i][j] + count) % mod_val;
                }
            }
        }

        dp[n][k]
    }
}