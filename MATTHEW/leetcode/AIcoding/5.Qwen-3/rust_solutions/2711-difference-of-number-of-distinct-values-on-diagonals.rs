impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn difference_of_distinct_values(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut result = vec![vec![0; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                let (mut diag1, mut diag2) = (HashMap::new(), HashMap::new());
                let (mut x, mut y) = (i, j);
                while x < rows && y < cols {
                    *diag1.entry(grid[x][y]).or_insert(0) += 1;
                    x += 1;
                    y += 1;
                }
                let (mut x, mut y) = (i, j);
                while x >= 0 && y >= 0 {
                    *diag2.entry(grid[x][y]).or_insert(0) += 1;
                    x -= 1;
                    y -= 1;
                }
                let count1 = diag1.len() as i32;
                let count2 = diag2.len() as i32;
                result[i][j] = (count1 - count2).abs();
            }
        }

        result
    }
}
}