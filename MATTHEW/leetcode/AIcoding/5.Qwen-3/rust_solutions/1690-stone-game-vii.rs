struct Solution;

impl Solution {
    pub fn stone_game_vii(stones: Vec<i32>) -> i32 {
        let n = stones.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 0;
        }

        for length in 2..=n {
            for i in 0..n - length + 1 {
                let j = i + length - 1;
                dp[i][j] = (stones[i] + dp[i + 1][j]).max(stones[j] + dp[i][j - 1]);
            }
        }

        dp[0][n - 1]
    }
}