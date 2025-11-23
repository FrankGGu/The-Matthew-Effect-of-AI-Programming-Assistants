impl Solution {
    pub fn cherry_pickup(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut dp = vec![vec![i32::MIN; n]; n];
        dp[0][0] = grid[0][0];

        for step in 1..=2 * n - 2 {
            let mut new_dp = vec![vec![i32::MIN; n]; n];
            for i in 0..n {
                for j in 0..n {
                    if dp[i][j] == i32::MIN {
                        continue;
                    }
                    for di in 0..2 {
                        for dj in 0..2 {
                            if di + dj != 1 {
                                continue;
                            }
                            let x1 = i + di;
                            let y1 = step - x1;
                            let x2 = j + dj;
                            let y2 = step - x2;

                            if x1 >= 0 && x1 < n && y1 >= 0 && y1 < n && x2 >= 0 && x2 < n && y2 >= 0 && y2 < n && grid[x1][y1] != -1 && grid[x2][y2] != -1 {
                                let mut cherries = grid[x1][y1];
                                if x1 != x2 {
                                    cherries += grid[x2][y2];
                                }
                                new_dp[x1][x2] = new_dp[x1][x2].max(dp[i][j] + cherries);
                            }
                        }
                    }
                }
            }
            dp = new_dp;
        }

        dp[n - 1][n - 1].max(0)
    }
}