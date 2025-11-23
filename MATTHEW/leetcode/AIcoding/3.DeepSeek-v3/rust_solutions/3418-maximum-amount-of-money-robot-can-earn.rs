impl Solution {
    pub fn max_money(coins: Vec<i32>) -> i32 {
        let n = coins.len();
        if n == 0 {
            return 0;
        }
        let mut dp = vec![vec![0; n]; n];
        for i in 0..n {
            dp[i][i] = coins[i];
        }
        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                let pick_left = coins[i] - dp[i + 1][j];
                let pick_right = coins[j] - dp[i][j - 1];
                dp[i][j] = pick_left.max(pick_right);
            }
        }
        dp[0][n - 1]
    }
}