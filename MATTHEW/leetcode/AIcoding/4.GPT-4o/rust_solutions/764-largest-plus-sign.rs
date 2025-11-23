impl Solution {
    pub fn order_of_largest_plus_sign(n: i32, mines: Vec<Vec<i32>>) -> i32 {
        let mut grid = vec![vec![1; n as usize]; n as usize];
        for mine in mines {
            grid[mine[0] as usize][mine[1] as usize] = 0;
        }

        let mut max_order = 0;
        let mut dp = vec![vec![0; n as usize]; n as usize];

        for i in 0..n {
            for j in 0..n {
                if grid[i as usize][j as usize] == 1 {
                    dp[i as usize][j as usize] = if i == 0 || j == 0 {
                        1
                    } else {
                        dp[(i - 1) as usize][j as usize].min(dp[i as usize][(j - 1) as usize]) + 1
                    };
                    max_order = max_order.max(dp[i as usize][j as usize]);
                }
            }
        }

        max_order
    }
}