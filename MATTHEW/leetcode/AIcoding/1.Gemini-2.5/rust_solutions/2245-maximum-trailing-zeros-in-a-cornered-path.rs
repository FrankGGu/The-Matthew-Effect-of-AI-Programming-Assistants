impl Solution {
    pub fn max_trailing_zeros(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut factors = vec![vec![(0, 0); n]; m];
        for i in 0..m {
            for j in 0..n {
                factors[i][j] = Self::get_factors(grid[i][j]);
            }
        }

        let mut dp_left = vec![vec![(0, 0); n]; m];
        let mut dp_right = vec![vec![(0, 0); n]; m];
        let mut dp_up = vec![vec![(0, 0); n]; m];
        let mut dp_down = vec![vec![(0, 0); n]; m];

        for i in 0..m {
            for j in 0..n {
                if j == 0 {
                    dp_left[i][j] = factors[i][j];
                } else {
                    dp_left[i][j].0 = dp_left[i][j - 1].0 + factors[i][j].0;
                    dp_left[i][j].1 = dp_left[i][j - 1].1 + factors[i][j].1;
                }
            }
        }

        for i in 0..m {
            for j in (0..n).rev() {
                if j == n - 1 {
                    dp_right[i][j] = factors[i][j];
                } else {
                    dp_right[i][j].0 = dp_right[i][j + 1].0 + factors[i][j].0;
                    dp_right[i][j].1 = dp_right[i][j + 1].1 + factors[i][j].1;
                }
            }
        }

        for j in 0..n {
            for i in 0..m {
                if i == 0 {
                    dp_up[i][j] = factors[i][j];
                } else {
                    dp_up[i][j].0 = dp_up[i - 1][j].0 + factors[i][j].0;
                    dp_up[i][j].1 = dp_up[i - 1][j].1 + factors[i][j].1;
                }
            }
        }

        for j in 0..n {
            for i in (0..m).rev() {
                if i == m - 1 {
                    dp_down[i][j] = factors[i][j];
                } else {
                    dp_down[i][j].0 = dp_down[i + 1][j].0 + factors[i][j].0;
                    dp_down[i][j].1 = dp_down[i + 1][j].1 + factors[i][j].1;
                }
            }
        }

        let mut max_zeros = 0;

        for i in 0..m {
            for j in 0..n {
                let (f2, f5) = factors[i][j];

                // Case: Left -> Up
                // Path requires segments of length > 0.
                // Left segment: (i,0) ... (i,j) => j > 0
                // Up segment: (0,j) ... (i,j) => i > 0
                if i > 0 && j > 0 {
                    let t2 = dp_left[i][j].0 + dp_up[i][j].0 - f2;
                    let t5 = dp_left[i][j].1 + dp_up[i][j].1 - f5;
                    max_zeros = max_zeros.max(t2.min(t5));
                }

                // Case: Left -> Down
                // Left segment: (i,0) ... (i,j) => j > 0
                // Down segment: (i,j) ... (M-1,j) => i < M-1
                if i < m - 1 && j > 0 {
                    let t2 = dp_left[i][j].0 + dp_down[i][j].0 - f2;
                    let t5 = dp_left[i][j].1 + dp_down[i][j].1 - f5;
                    max_zeros = max_zeros.max(t2.min(t5));
                }

                // Case: Right -> Up
                // Right segment: (i,j) ... (i,N-1) => j < N-1
                // Up segment: (0,j) ... (i,j) => i > 0
                if i > 0 && j < n - 1 {
                    let t2 = dp_right[i][j].0 + dp_up[i][j].0 - f2;
                    let t5 = dp_right[i][j].1 + dp_up[i][j].1 - f5;
                    max_zeros = max_zeros.max(t2.min(t5));
                }

                // Case: Right -> Down
                // Right segment: (i,j) ... (i,N-1) => j < N-1
                // Down segment: (i,j) ... (M-1,j) => i < M-1
                if i < m - 1 && j < n - 1 {
                    let t2 = dp_right[i][j].0 + dp_down[i][j].0 - f2;
                    let t5 = dp_right[i][j].1 + dp_down[i][j].1 - f5;
                    max_zeros = max_zeros.max(t2.min(t5));
                }
            }
        }

        max_zeros
    }

    fn get_factors(mut n: i32) -> (i32, i32) {
        let mut count2 = 0;
        let mut count5 = 0;
        while n > 0 && n % 2 == 0 {
            count2 += 1;
            n /= 2;
        }
        while n > 0 && n % 5 == 0 {
            count5 += 1;
            n /= 5;
        }
        (count2, count5)
    }
}