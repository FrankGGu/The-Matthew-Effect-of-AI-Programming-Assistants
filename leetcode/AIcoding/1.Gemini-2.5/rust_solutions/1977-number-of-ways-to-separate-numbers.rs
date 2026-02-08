struct Solution;

impl Solution {
    pub fn number_of_ways(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mod_val = 1_000_000_007;

        let mut lcp = vec![vec![0; n + 1]; n + 1];
        for i in (0..n).rev() {
            for j in (0..n).rev() {
                if s_bytes[i] == s_bytes[j] {
                    lcp[i][j] = 1 + lcp[i + 1][j + 1];
                } else {
                    lcp[i][j] = 0;
                }
            }
        }

        let mut dp = vec![vec![0; n]; n + 1];
        let mut prefix_sums = vec![vec![0; n]; n + 1];

        for i in 1..=n {
            for j in 0..i {
                if s_bytes[j] == b'0' && i - 1 > j {
                    dp[i][j] = 0;
                } else {
                    let len_curr = i - j;

                    if j == 0 {
                        dp[i][j] = 1;
                    } else {
                        let mut current_ways = 0;

                        let k_max_for_smaller_len = j - len_curr - 1;
                        if k_max_for_smaller_len >= 0 {
                            current_ways = (current_ways + prefix_sums[j][k_max_for_smaller_len]) % mod_val;
                        }

                        let k_eq = j - len_curr;
                        if k_eq >= 0 {
                            let l = lcp[j][k_eq];
                            if l >= len_curr || s_bytes[j + l] <= s_bytes[k_eq + l] {
                                current_ways = (current_ways + dp[j][k_eq]) % mod_val;
                            }
                        }
                        dp[i][j] = current_ways;
                    }
                }

                if j == 0 {
                    prefix_sums[i][j] = dp[i][j];
                } else {
                    prefix_sums[i][j] = (prefix_sums[i][j - 1] + dp[i][j]) % mod_val;
                }
            }
        }

        prefix_sums[n][n - 1] as i32
    }
}