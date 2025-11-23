impl Solution {
    pub fn calculate_minimum_hp(dungeon: Vec<Vec<i32>>) -> i32 {
        let m = dungeon.len();
        let n = dungeon[0].len();
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in 0..=m {
            dp[i][n] = i32::MAX;
        }
        for j in 0..=n {
            dp[m][j] = i32::MAX;
        }

        dp[m][n - 1] = 1;
        dp[m - 1][n] = 1;

        for i in (0..m).rev() {
            for j in (0..n).rev() {
                let need = std::cmp::min(dp[i + 1][j], dp[i][j + 1]) - dungeon[i][j];
                dp[i][j] = std::cmp::max(1, need);
            }
        }

        dp[0][0]
    }
}