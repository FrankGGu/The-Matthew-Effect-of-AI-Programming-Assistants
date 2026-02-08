impl Solution {
    pub fn cherry_pickup(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut dp = vec![vec![vec![-1; cols]; cols]; rows];
        dp[0][0][cols - 1] = grid[0][0] + grid[0][cols - 1];

        for i in 1..rows {
            for j1 in 0..cols {
                for j2 in 0..cols {
                    let mut max_prev = -1;
                    for &dj1 in &[-1, 0, 1] {
                        let prev_j1 = j1 as i32 + dj1;
                        if prev_j1 < 0 || prev_j1 >= cols as i32 {
                            continue;
                        }
                        for &dj2 in &[-1, 0, 1] {
                            let prev_j2 = j2 as i32 + dj2;
                            if prev_j2 < 0 || prev_j2 >= cols as i32 {
                                continue;
                            }
                            let prev_val = dp[i - 1][prev_j1 as usize][prev_j2 as usize];
                            if prev_val > max_prev {
                                max_prev = prev_val;
                            }
                        }
                    }
                    if max_prev != -1 {
                        let cherries = if j1 == j2 {
                            grid[i][j1]
                        } else {
                            grid[i][j1] + grid[i][j2]
                        };
                        dp[i][j1][j2] = max_prev + cherries;
                    }
                }
            }
        }

        *dp[rows - 1].iter().flatten().max().unwrap()
    }
}