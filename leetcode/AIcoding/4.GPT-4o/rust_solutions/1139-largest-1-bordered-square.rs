impl Solution {
    pub fn largest1_bordered_square(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n + 1]; m + 1];
        let mut max_len = 0;

        for i in 1..=m {
            for j in 1..=n {
                if grid[i - 1][j - 1] == 1 {
                    dp[i][j] = dp[i - 1][j].min(dp[i][j - 1]).min(dp[i - 1][j - 1]) + 1;
                    let len = dp[i][j];
                    if len > max_len {
                        if dp[i][j - len as usize + 1] >= len && dp[i - len as usize + 1][j] >= len {
                            max_len = len;
                        }
                    }
                }
            }
        }

        (max_len * max_len) as i32
    }
}