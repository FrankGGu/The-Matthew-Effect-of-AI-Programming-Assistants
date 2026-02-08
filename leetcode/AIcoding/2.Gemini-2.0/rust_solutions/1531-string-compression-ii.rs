impl Solution {
    pub fn get_length_of_optimal_compression(s: String, k: i32) -> i32 {
        let n = s.len();
        let s = s.as_bytes();
        let k = k as usize;

        let mut dp = vec![vec![i32::MAX; k + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 0..=k {
                if j > 0 {
                    dp[i][j] = dp[i][j].min(dp[i - 1][j - 1]);
                }

                let mut count = 0;
                let mut del = 0;
                for l in (1..=i).rev() {
                    if s[l - 1] == s[i - 1] {
                        count += 1;
                    } else {
                        del += 1;
                    }

                    if del > j {
                        break;
                    }

                    let len = match count {
                        1 => 1,
                        2..=9 => 2,
                        10..=99 => 3,
                        _ => 4,
                    };

                    dp[i][j] = dp[i][j].min(dp[l - 1][j - del] + len);
                }
            }
        }

        let mut ans = i32::MAX;
        for j in 0..=k {
            ans = ans.min(dp[n][j]);
        }

        ans
    }
}