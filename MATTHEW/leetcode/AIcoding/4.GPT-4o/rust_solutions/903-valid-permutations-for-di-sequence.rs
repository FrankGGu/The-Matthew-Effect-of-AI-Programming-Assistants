impl Solution {
    pub fn count_permutations(s: String) -> i32 {
        let n = s.len();
        let mut dp = vec![vec![0; n + 1]; n + 1];
        dp[0][0] = 1;

        for i in 0..n {
            for j in 0..=i {
                if s.chars().nth(i) == Some('I') {
                    for k in (j + 1)..=i + 1 {
                        dp[i + 1][k] += dp[i][j];
                    }
                } else {
                    for k in 0..=j {
                        dp[i + 1][k] += dp[i][j];
                    }
                }
            }
        }

        dp[n].iter().sum::<i32>()
    }
}