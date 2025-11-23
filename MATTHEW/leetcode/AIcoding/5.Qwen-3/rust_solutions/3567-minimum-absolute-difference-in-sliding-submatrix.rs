impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn minimum_difference(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let k = k as usize;

        let mut min_diff = i32::MAX;

        for i in 0..n - k + 1 {
            for j in 0..m - k + 1 {
                let mut values = Vec::new();
                for x in i..i + k {
                    for y in j..j + k {
                        values.push(grid[x][y]);
                    }
                }
                values.sort();
                for l in 0..values.len() - 1 {
                    min_diff = min_diff.min(values[l + 1] - values[l]);
                }
            }
        }

        min_diff
    }
}
}