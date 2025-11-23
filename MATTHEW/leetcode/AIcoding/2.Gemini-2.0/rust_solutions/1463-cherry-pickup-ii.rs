impl Solution {
    pub fn cherry_pickup(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![vec![0; n]; n]; 2];

        for r in (0..m).rev() {
            for c1 in 0..n {
                for c2 in 0..n {
                    let mut cherries = grid[r][c1];
                    if c1 != c2 {
                        cherries += grid[r][c2];
                    }

                    let mut max_cherries = 0;
                    for dc1 in -1..=1 {
                        for dc2 in -1..=1 {
                            let nc1 = c1 as i32 + dc1;
                            let nc2 = c2 as i32 + dc2;

                            if nc1 >= 0 && nc1 < n as i32 && nc2 >= 0 && nc2 < n as i32 {
                                max_cherries = max_cherries.max(dp[(r + 1) % 2][nc1 as usize][nc2 as usize]);
                            }
                        }
                    }
                    dp[r % 2][c1][c2] = cherries + max_cherries;
                }
            }
        }

        dp[0][0][n - 1]
    }
}