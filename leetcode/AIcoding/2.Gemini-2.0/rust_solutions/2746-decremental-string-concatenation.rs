impl Solution {
    pub fn minimize_concatenated_length(words: Vec<String>) -> i32 {
        let n = words.len();
        let mut dp = vec![vec![vec![i32::MAX; 26]; 26]; n + 1];
        dp[0][0][0] = 0;

        for i in 0..n {
            let word = &words[i];
            let len = word.len() as i32;
            let first = (word.as_bytes()[0] - b'a') as usize;
            let last = (word.as_bytes()[word.len() - 1] - b'a') as usize;

            for j in 0..26 {
                for k in 0..26 {
                    if dp[i][j][k] != i32::MAX {
                        let cost1 = if k == first {
                            -1
                        } else {
                            0
                        };
                        dp[i + 1][j][last] = dp[i + 1][j][last].min(dp[i][j][k] + len + cost1);

                        let cost2 = if last == j {
                            -1
                        } else {
                            0
                        };
                        dp[i + 1][first][k] = dp[i + 1][first][k].min(dp[i][j][k] + len + cost2);
                    }
                }
            }
        }

        let mut ans = i32::MAX;
        for i in 0..26 {
            for j in 0..26 {
                ans = ans.min(dp[n][i][j]);
            }
        }
        ans
    }
}