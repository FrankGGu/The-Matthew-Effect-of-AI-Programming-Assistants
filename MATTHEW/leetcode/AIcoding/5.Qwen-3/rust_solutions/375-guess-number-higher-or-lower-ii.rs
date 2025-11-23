struct Solution {}

impl Solution {
    pub fn get_money_amount(n: i32) -> i32 {
        let n = n as usize;
        let mut dp = vec![vec![0; n + 1]; n + 1];

        for i in 1..n {
            dp[i][i + 1] = i;
        }

        for length in 2..n {
            for i in 1..=n - length {
                let j = i + length;
                dp[i][j] = std::i32::MAX;
                for k in i..=j {
                    let cost = k + std::cmp::min(dp[i][k - 1], dp[k + 1][j]);
                    dp[i][j] = std::cmp::min(dp[i][j], cost);
                }
            }
        }

        dp[1][n]
    }
}