impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn number_of_right_triangles(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut row_counts = vec![0; rows];
        let mut col_counts = vec![0; cols];
        let mut points = HashSet::new();

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    row_counts[i] += 1;
                    col_counts[j] += 1;
                    points.insert((i, j));
                }
            }
        }

        let mut result = 0;

        for &(i, j) in &points {
            let count = (row_counts[i] - 1) * (col_counts[j] - 1);
            result += count;
        }

        result
    }
}
}