impl Solution {
    pub fn cherry_pickup(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![vec![-1; n]; n]; m];

        for j1 in 0..n {
            for j2 in 0..n {
                if j1 == j2 {
                    dp[0][j1][j2] = grid[0][j1];
                } else {
                    dp[0][j1][j2] = grid[0][j1] + grid[0][j2];
                }
            }
        }

        for i in 1..m {
            for j1 in 0..n {
                for j2 in 0..n {
                    let mut max_cherries = 0;
                    for dj1 in -1..=1 {
                        for dj2 in -1..=1 {
                            let nj1 = j1 as isize + dj1;
                            let nj2 = j2 as isize + dj2;
                            if nj1 >= 0 && nj1 < n as isize && nj2 >= 0 && nj2 < n as isize {
                                let cherries = dp[i - 1][nj1 as usize][nj2 as usize];
                                if cherries >= 0 {
                                    max_cherries = max_cherries.max(cherries);
                                }
                            }
                        }
                    }
                    if max_cherries >= 0 {
                        dp[i][j1][j2] = max_cherries + if j1 == j2 { grid[i][j1] } else { grid[i][j1] + grid[i][j2] };
                    }
                }
            }
        }

        let mut result = 0;
        for j1 in 0..n {
            for j2 in 0..n {
                result = result.max(dp[m - 1][j1][j2]);
            }
        }
        result
    }
}