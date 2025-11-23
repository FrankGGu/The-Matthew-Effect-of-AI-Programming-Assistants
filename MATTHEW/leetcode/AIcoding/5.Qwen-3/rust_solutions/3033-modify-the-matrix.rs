impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn modified_matrix(matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut result = matrix.clone();

        let mut zero_rows = HashSet::new();
        let mut zero_cols = HashSet::new();

        for i in 0..rows {
            for j in 0..cols {
                if matrix[i][j] == 0 {
                    zero_rows.insert(i);
                    zero_cols.insert(j);
                }
            }
        }

        for i in 0..rows {
            for j in 0..cols {
                if zero_rows.contains(&i) || zero_cols.contains(&j) {
                    result[i][j] = 0;
                }
            }
        }

        result
    }
}
}