impl Solution {
    pub fn beautiful_partitions(s: String, k: i32, min_length: i32) -> i32 {
        let s = s.chars().collect::<Vec<_>>();
        let n = s.len();
        let k = k as usize;
        let min_length = min_length as usize;
        let mod_num = 1_000_000_007;

        if k * min_length > n {
            return 0;
        }

        let is_prime = |c: char| -> bool {
            matches!(c, '2' | '3' | '5' | '7')
        };

        if !is_prime(s[0]) || is_prime(s[n - 1]) {
            return 0;
        }

        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[0][0] = 1;

        for j in 1..=k {
            let mut prefix = vec![0; n + 1];
            for i in 0..n {
                prefix[i + 1] = (prefix[i] + dp[i][j - 1]) % mod_num;
            }
            for i in min_length..=n {
                if i < min_length || !is_prime(s[i - 1]) {
                    continue;
                }
                let start = if j == 1 { 0 } else { min_length };
                let end = i - min_length;
                if start > end {
                    continue;
                }
                dp[i][j] = (dp[i][j] + prefix[end + 1] - prefix[start] + mod_num) % mod_num;
            }
        }

        dp[n][k]
    }
}