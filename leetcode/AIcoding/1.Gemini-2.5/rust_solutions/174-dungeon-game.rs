impl Solution {
    pub fn calculate_minimum_hp(dungeon: Vec<Vec<i32>>) -> i32 {
        let m = dungeon.len();
        let n = dungeon[0].len();

        let mut dp = vec![0; n];

        for i in (0..m).rev() {
            for j in (0..n).rev() {
                if i == m - 1 && j == n - 1 {
                    dp[j] = (1 - dungeon[i][j]).max(1);
                } else if i == m - 1 {
                    dp[j] = (dp[j + 1] - dungeon[i][j]).max(1);
                } else if j == n - 1 {
                    dp[j] = (dp[j] - dungeon[i][j]).max(1);
                } else {
                    let min_health_to_next_step = dp[j + 1].min(dp[j]);
                    dp[j] = (min_health_to_next_step - dungeon[i][j]).max(1);
                }
            }
        }

        dp[0]
    }
}