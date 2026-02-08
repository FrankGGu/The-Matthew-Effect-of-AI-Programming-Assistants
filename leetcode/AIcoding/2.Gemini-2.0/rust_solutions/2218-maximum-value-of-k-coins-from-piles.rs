impl Solution {
    pub fn max_value_of_coins(piles: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = piles.len();
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n + 1];

        for i in 1..=n {
            for j in 0..=k {
                dp[i][j] = dp[i - 1][j];
                let mut current_sum = 0;
                for x in 0..=std::cmp::min(j, piles[i - 1].len()) {
                    if x > 0 {
                        current_sum += piles[i - 1][x - 1];
                    }
                    if j >= x {
                        dp[i][j] = std::cmp::max(dp[i][j], dp[i - 1][j - x] + current_sum);
                    }
                }
            }
        }

        dp[n][k]
    }
}