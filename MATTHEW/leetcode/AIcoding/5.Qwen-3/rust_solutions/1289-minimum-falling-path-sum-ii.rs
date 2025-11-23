impl Solution {

use std::cmp::Min;

impl Solution {
    pub fn min_falling_path_sum(mut grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if n == 1 {
            return grid[0][0];
        }

        for i in 1..n {
            let mut min1 = i32::MAX;
            let mut min2 = i32::MAX;
            let mut idx = -1;

            for j in 0..n {
                if grid[i - 1][j] < min1 {
                    min2 = min1;
                    min1 = grid[i - 1][j];
                    idx = j as i32;
                } else if grid[i - 1][j] < min2 {
                    min2 = grid[i - 1][j];
                }
            }

            for j in 0..n {
                if j as i32 == idx {
                    grid[i][j] += min2;
                } else {
                    grid[i][j] += min1;
                }
            }
        }

        *grid.last().unwrap().iter().min().unwrap()
    }
}
}