impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_flips(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut flips = 0;

        for i in 0..m {
            for j in 0..n / 2 {
                if grid[i][j] != grid[i][n - 1 - j] {
                    flips += 1;
                }
            }
        }

        for j in 0..n {
            for i in 0..m / 2 {
                if grid[i][j] != grid[m - 1 - i][j] {
                    flips += 1;
                }
            }
        }

        flips
    }
}
}