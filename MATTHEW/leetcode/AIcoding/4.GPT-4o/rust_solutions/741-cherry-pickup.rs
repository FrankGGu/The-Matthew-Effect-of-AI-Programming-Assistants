impl Solution {
    pub fn cherry_pickup(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut dp = vec![vec![vec![0; m]; m]; n];

        for i in (0..n).rev() {
            for j1 in 0..m {
                for j2 in 0..m {
                    let cherries = if j1 == j2 { grid[i][j1] } else { grid[i][j1] + grid[i][j2] };
                    if i + 1 < n {
                        let mut max_next = 0;
                        for dj1 in -1..=1 {
                            for dj2 in -1..=1 {
                                let nj1 = (j1 as isize + dj1) as usize;
                                let nj2 = (j2 as isize + dj2) as usize;
                                if nj1 < m && nj2 < m {
                                    max_next = max_next.max(dp[i + 1][nj1][nj2]);
                                }
                            }
                        }
                        dp[i][j1][j2] = cherries + max_next;
                    } else {
                        dp[i][j1][j2] = cherries;
                    }
                }
            }
        }

        dp[0][0][m - 1]
    }
}