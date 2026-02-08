impl Solution {
    pub fn max_area_of_square(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut dp = vec![vec![0; m]; n];
        let mut max_side = 0;

        for i in 0..n {
            for j in 0..m {
                if grid[i][j] == 1 {
                    dp[i][j] = if i == 0 || j == 0 {
                        1
                    } else {
                        dp[i - 1][j - 1].min(dp[i - 1][j]).min(dp[i][j - 1]) + 1
                    };
                    max_side = max_side.max(dp[i][j]);
                }
            }
        }

        max_side * max_side
    }
}