impl Solution {
    pub fn count_fertile_pyramids(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut dp_pyramid = vec![vec![0; n]; m];
        let mut dp_inverted_pyramid = vec![vec![0; n]; m];

        let mut total_fertile_shapes = 0;
        let mut count_ones = 0;

        for r in (0..m).rev() {
            for c in 0..n {
                if grid[r][c] == 1 {
                    count_ones += 1;
                    if r == m - 1 || c == 0 || c == n - 1 {
                        dp_pyramid[r][c] = 1;
                    } else {
                        if grid[r + 1][c - 1] == 1 && grid[r + 1][c] == 1 && grid[r + 1][c + 1] == 1 {
                            dp_pyramid[r][c] = 1 + dp_pyramid[r + 1][c - 1]
                                .min(dp_pyramid[r + 1][c])
                                .min(dp_pyramid[r + 1][c + 1]);
                        } else {
                            dp_pyramid[r][c] = 1;
                        }
                    }
                    total_fertile_shapes += dp_pyramid[r][c];
                }
            }
        }

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    if r == 0 || c == 0 || c == n - 1 {
                        dp_inverted_pyramid[r][c] = 1;
                    } else {
                        if grid[r - 1][c - 1] == 1 && grid[r - 1][c] == 1 && grid[r - 1][c + 1] == 1 {
                            dp_inverted_pyramid[r][c] = 1 + dp_inverted_pyramid[r - 1][c - 1]
                                .min(dp_inverted_pyramid[r - 1][c])
                                .min(dp_inverted_pyramid[r - 1][c + 1]);
                        } else {
                            dp_inverted_pyramid[r][c] = 1;
                        }
                    }
                    total_fertile_shapes += dp_inverted_pyramid[r][c];
                }
            }
        }

        total_fertile_shapes - count_ones
    }
}