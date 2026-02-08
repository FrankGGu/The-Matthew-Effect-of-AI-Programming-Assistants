impl Solution {
    pub fn stone_game(piles: Vec<i32>) -> bool {
        let n = piles.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = piles[i];
        }

        for len in 1..n {
            for i in 0..n - len {
                let j = i + len;
                dp[i][j] = (piles[i] - dp[i + 1][j]).max(piles[j] - dp[i][j - 1]);
            }
        }

        dp[0][n - 1] > 0
    }
}