impl Solution {
    pub fn get_length_of_optimal_compression(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let k = k as usize;
        let mut dp = vec![vec![n as i32; k + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 0..=k {
                if j > 0 {
                    dp[i][j] = dp[i - 1][j - 1];
                }
                let mut cnt = 0;
                let mut del = 0;
                for l in (1..=i).rev() {
                    if s[l - 1] == s[i - 1] {
                        cnt += 1;
                    } else {
                        del += 1;
                    }
                    if del > j {
                        break;
                    }
                    let len = if cnt == 1 {
                        1
                    } else if cnt < 10 {
                        2
                    } else if cnt < 100 {
                        3
                    } else {
                        4
                    };
                    dp[i][j] = dp[i][j].min(dp[l - 1][j - del] + len);
                }
            }
        }
        dp[n][k]
    }
}