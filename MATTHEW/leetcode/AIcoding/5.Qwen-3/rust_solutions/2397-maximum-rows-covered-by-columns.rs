impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn maximum_rows_covered_by_columns(matrix: Vec<Vec<char>>, cols: Vec<i32>) -> i32 {
        let mut covered = HashSet::new();
        for &col in &cols {
            for row in 0..matrix.len() {
                if matrix[row][col as usize] == '1' {
                    covered.insert(row);
                }
            }
        }
        covered.len() as i32
    }
}
}