impl Solution {
    pub fn calculate_min_hp(dungeon: Vec<Vec<i32>>) -> i32 {
        let m = dungeon.len();
        let n = dungeon[0].len();
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in (0..=m).rev() {
            for j in (0..=n).rev() {
                if i == m && j == n {
                    dp[i][j] = 1;
                } else if i == m {
                    dp[i][j] = dp[i][j + 1] - dungeon[i][j].max(0);
                } else if j == n {
                    dp[i][j] = dp[i + 1][j] - dungeon[i][j].max(0);
                } else {
                    dp[i][j] = dp[i + 1][j].min(dp[i][j + 1]) - dungeon[i][j].max(0);
                }
                if dp[i][j] <= 0 {
                    dp[i][j] = 1;
                }
            }
        }
        dp[0][0]
    }
}