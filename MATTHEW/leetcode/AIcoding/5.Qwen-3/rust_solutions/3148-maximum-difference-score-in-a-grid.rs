impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn maximum_difference(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut max_diff = 0;

        for i in 0..rows {
            for j in 0..cols {
                for k in i + 1..rows {
                    for l in 0..cols {
                        match grid[k][l].cmp(&grid[i][j]) {
                            Ordering::Greater => {
                                let diff = grid[k][l] - grid[i][j];
                                if diff > max_diff {
                                    max_diff = diff;
                                }
                            },
                            _ => {}
                        }
                    }
                }
            }
        }

        max_diff
    }
}
}