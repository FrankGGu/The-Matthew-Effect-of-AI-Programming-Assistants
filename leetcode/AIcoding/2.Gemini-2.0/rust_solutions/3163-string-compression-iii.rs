impl Solution {
    pub fn string_compression(s: String, k: i32) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut dp = vec![vec![n as i32; k as usize + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 0..=k as usize {
                if j > 0 {
                    dp[i][j] = dp[i][j].min(dp[i - 1][j - 1]);
                }

                let mut diff = 0;
                let mut count = 0;
                for l in (1..=i).rev() {
                    if s[l - 1] == s[i - 1] {
                        count += 1;
                    } else {
                        diff += 1;
                    }

                    if diff > j {
                        break;
                    }

                    let len = if count == 1 {
                        1
                    } else if count < 10 {
                        2
                    } else if count < 100 {
                        3
                    } else {
                        4
                    };

                    dp[i][j] = dp[i][j].min(dp[l - 1][j - diff] + len);
                }
            }
        }

        let mut ans = n as i32;
        for j in 0..=k as usize {
            ans = ans.min(dp[n][j]);
        }

        ans
    }
}