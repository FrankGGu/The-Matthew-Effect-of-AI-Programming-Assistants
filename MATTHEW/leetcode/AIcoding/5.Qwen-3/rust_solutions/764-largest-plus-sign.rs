impl Solution {

use std::cmp::min;

impl Solution {
    pub fn order_of_largest_plus_sign(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut left = vec![vec![0; m]; n];
        let mut right = vec![vec![0; m]; n];
        let mut up = vec![vec![0; m]; n];
        let mut down = vec![vec![0; m]; n];

        for i in 0..n {
            for j in 0..m {
                if grid[i][j] == 1 {
                    left[i][j] = if j > 0 { left[i][j - 1] + 1 } else { 1 };
                    up[i][j] = if i > 0 { up[i - 1][j] + 1 } else { 1 };
                }
            }
        }

        for i in 0..n {
            for j in (0..m).rev() {
                if grid[i][j] == 1 {
                    right[i][j] = if j < m - 1 { right[i][j + 1] + 1 } else { 1 };
                    down[i][j] = if i < n - 1 { down[i + 1][j] + 1 } else { 1 };
                }
            }
        }

        let mut max_size = 0;
        for i in 0..n {
            for j in 0..m {
                let size = min(left[i][j], right[i][j]);
                let size = min(size, up[i][j]);
                let size = min(size, down[i][j]);
                max_size = max_size.max(size);
            }
        }

        max_size
    }
}
}