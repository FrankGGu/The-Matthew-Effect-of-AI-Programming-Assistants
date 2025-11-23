impl Solution {
    pub fn paint_walls(cost: Vec<i32>, time: Vec<i32>) -> i32 {
        let n = cost.len();
        let mut dp = vec![vec![i32::MAX / 2; n + 1]; n + 1];
        dp[0][0] = 0;

        for i in 0..n {
            for j in 0..=n {
                if dp[i][j] == i32::MAX / 2 {
                    continue;
                }
                // Option 1: Don't take the current painter
                if dp[i + 1][j] > dp[i][j] {
                    dp[i + 1][j] = dp[i][j];
                }
                // Option 2: Take the current painter
                let new_j = (j + time[i] as usize + 1).min(n);
                if dp[i + 1][new_j] > dp[i][j] + cost[i] {
                    dp[i + 1][new_j] = dp[i][j] + cost[i];
                }
            }
        }

        dp[n][n]
    }
}