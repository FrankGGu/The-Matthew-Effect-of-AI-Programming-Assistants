impl Solution {
    pub fn max_energy(dungeon: Vec<Vec<i32>>) -> i32 {
        let m = dungeon.len();
        let n = dungeon[0].len();

        let mut dp = vec![vec![i32::MIN; n]; m];

        for i in (0..m).rev() {
            for j in (0..n).rev() {
                if i == m - 1 && j == n - 1 {
                    dp[i][j] = dungeon[i][j];
                } else if i == m - 1 {
                    dp[i][j] = dungeon[i][j] + dp[i][j + 1];
                } else if j == n - 1 {
                    dp[i][j] = dungeon[i][j] + dp[i + 1][j];
                } else {
                    dp[i][j] = dungeon[i][j] + std::cmp::max(dp[i + 1][j], dp[i][j + 1]);
                }
            }
        }

        dp[0][0]
    }
}