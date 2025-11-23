impl Solution {
    pub fn max_special_substrings(s: String, k: i32, target: String) -> i32 {
        let s = s.as_bytes();
        let target = target.as_bytes();
        let n = s.len();
        let m = target.len();
        let k = k as usize;

        let mut dp = vec![vec![0; k + 1]; n + 1];

        for i in 1..=n {
            for j in 1..=k {
                dp[i][j] = dp[i - 1][j];
                if i >= m {
                    let mut match_found = true;
                    for l in 0..m {
                        if s[i - m + l] != target[l] {
                            match_found = false;
                            break;
                        }
                    }
                    if match_found {
                        dp[i][j] = dp[i][j].max(dp[i - m][j - 1] + 1);
                    }
                }
            }
        }

        dp[n][k]
    }
}