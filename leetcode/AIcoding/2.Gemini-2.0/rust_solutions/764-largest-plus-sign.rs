impl Solution {
    pub fn order_of_largest_plus_sign(n: i32, mines: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut grid = vec![vec![1; n]; n];

        for mine in &mines {
            grid[mine[0] as usize][mine[1] as usize] = 0;
        }

        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            let mut count = 0;
            for j in 0..n {
                if grid[i][j] == 1 {
                    count += 1;
                } else {
                    count = 0;
                }
                dp[i][j] = count;
            }
            count = 0;
            for j in (0..n).rev() {
                if grid[i][j] == 1 {
                    count += 1;
                    dp[i][j] = dp[i][j].min(count);
                } else {
                    count = 0;
                }
            }
        }

        for j in 0..n {
            let mut count = 0;
            for i in 0..n {
                if grid[i][j] == 1 {
                    count += 1;
                } else {
                    count = 0;
                }
                dp[i][j] = dp[i][j].min(count);
            }
            count = 0;
            for i in (0..n).rev() {
                if grid[i][j] == 1 {
                    count += 1;
                    dp[i][j] = dp[i][j].min(count);
                } else {
                    count = 0;
                }
            }
        }

        let mut max_order = 0;
        for i in 0..n {
            for j in 0..n {
                max_order = max_order.max(dp[i][j]);
            }
        }

        max_order as i32
    }
}