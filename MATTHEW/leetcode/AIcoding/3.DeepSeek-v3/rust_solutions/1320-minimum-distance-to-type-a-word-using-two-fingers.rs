impl Solution {
    pub fn minimum_distance(word: String) -> i32 {
        let word = word.into_bytes();
        let n = word.len();
        let mut dp = vec![vec![vec![i32::MAX; 26]; 26]; n + 1];
        for i in 0..26 {
            for j in 0..26 {
                dp[0][i][j] = 0;
            }
        }

        for k in 1..=n {
            let c = (word[k - 1] - b'A') as usize;
            for i in 0..26 {
                for j in 0..26 {
                    if dp[k - 1][i][j] != i32::MAX {
                        if i == c || j == c {
                            dp[k][i][j] = dp[k][i][j].min(dp[k - 1][i][j]);
                        }
                        let cost_i = if k == 1 { 0 } else { Self::distance(i, c) };
                        dp[k][c][j] = dp[k][c][j].min(dp[k - 1][i][j] + cost_i);
                        let cost_j = if k == 1 { 0 } else { Self::distance(j, c) };
                        dp[k][i][c] = dp[k][i][c].min(dp[k - 1][i][j] + cost_j);
                    }
                }
            }
        }

        let mut res = i32::MAX;
        for i in 0..26 {
            for j in 0..26 {
                res = res.min(dp[n][i][j]);
            }
        }
        res
    }

    fn distance(a: usize, b: usize) -> i32 {
        let (x1, y1) = (a / 6, a % 6);
        let (x2, y2) = (b / 6, b % 6);
        (x1 as i32 - x2 as i32).abs() + (y1 as i32 - y2 as i32).abs()
    }
}