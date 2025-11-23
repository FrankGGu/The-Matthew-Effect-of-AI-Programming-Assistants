impl Solution {
    pub fn get_money_amount(n: i32) -> i32 {
        let n = n as usize;
        let mut dp = vec![vec![0; n + 2]; n + 2];

        for len in 2..=n {
            for i in 1..=n - len + 1 {
                let j = i + len - 1;
                dp[i][j] = i32::MAX;
                for k in i..=j {
                    let cost = k as i32 + std::cmp::max(dp[i][k - 1], dp[k + 1][j]);
                    if cost < dp[i][j] {
                        dp[i][j] = cost;
                    }
                }
            }
        }

        dp[1][n]
    }
}