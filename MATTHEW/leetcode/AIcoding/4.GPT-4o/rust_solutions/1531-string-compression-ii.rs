impl Solution {
    pub fn get_length_of_optimal_compression(s: String, k: i32) -> i32 {
        let n = s.len();
        let bytes = s.as_bytes();
        let k = k as usize;
        let mut dp = vec![vec![std::i32::MAX; k + 1]; n + 1];
        dp[0][0] = 0;

        for i in 0..n {
            for j in 0..=k {
                if dp[i][j] == std::i32::MAX {
                    continue;
                }
                let mut cnt = 0;
                let mut len = 0;
                for l in i..n {
                    if bytes[l] == bytes[i] {
                        cnt += 1;
                        len += 1 + if cnt == 1 { 0 } else { (cnt as f64).log10().ceil() as usize };
                    }
                    let remaining = k - (l - i + 1 - cnt);
                    if remaining >= 0 {
                        dp[l + 1][remaining] = dp[l + 1][remaining].min(dp[i][j] + len);
                    } else {
                        break;
                    }
                }
            }
        }

        *dp[n].iter().min().unwrap()
    }
}