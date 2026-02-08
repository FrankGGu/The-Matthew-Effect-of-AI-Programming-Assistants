impl Solution {
    pub fn max_value(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut dp = vec![vec![0; m]; n];

        for i in 0..n {
            for j in 0..m {
                dp[i][j] = grid[i][j];
                if i > 0 {
                    dp[i][j] = dp[i][j].max(dp[i-1][j]);
                }
                if j > 0 {
                    dp[i][j] = dp[i][j].max(dp[i][j-1]);
                }
            }
        }

        let mut max_sum = 0;

        for r1 in 0..n {
            for r2 in r1+1..n {
                for c1 in 0..m {
                    for c2 in c1+1..m {
                        let sum = grid[r1][c1] + grid[r1][c2] + grid[r2][c1] + grid[r2][c2];
                        max_sum = max_sum.max(sum);
                    }
                }
            }
        }

        max_sum
    }
}