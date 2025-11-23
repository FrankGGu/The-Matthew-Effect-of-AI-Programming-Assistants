struct Solution;

impl Solution {
    pub fn stone_game(piles: Vec<i32>) -> bool {
        let n = piles.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = piles[i];
        }

        for l in 1..n {
            for i in 0..n - l {
                let j = i + l;
                dp[i][j] = std::cmp::max(piles[i] - dp[i + 1][j], piles[j] - dp[i][j - 1]);
            }
        }

        dp[0][n - 1] > 0
    }
}