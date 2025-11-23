impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn lucky_numbers (matrix: Vec<Vec<i32>>) -> Vec<i32> {
        let rows = matrix.len();
        let cols = matrix[0].len();

        let mut min_in_rows = HashSet::new();

        for i in 0..rows {
            let mut min_val = matrix[i][0];
            for j in 1..cols {
                if matrix[i][j] < min_val {
                    min_val = matrix[i][j];
                }
            }
            min_in_rows.insert(min_val);
        }

        let mut result = Vec::new();

        for j in 0..cols {
            let mut max_val = matrix[0][j];
            for i in 1..rows {
                if matrix[i][j] > max_val {
                    max_val = matrix[i][j];
                }
            }
            if min_in_rows.contains(&max_val) {
                result.push(max_val);
            }
        }

        result
    }
}
}