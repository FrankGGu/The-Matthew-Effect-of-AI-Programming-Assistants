impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_operations(grid: Vec<Vec<i32>>) -> i32 {
        let mut operations = 0;
        let rows = grid.len();
        let cols = grid[0].len();

        for c in 0..cols {
            for r in 1..rows {
                if grid[r][c] <= grid[r - 1][c] {
                    operations += grid[r - 1][c] - grid[r][c] + 1;
                    grid[r][c] = grid[r - 1][c] + 1;
                }
            }
        }

        operations
    }
}
}