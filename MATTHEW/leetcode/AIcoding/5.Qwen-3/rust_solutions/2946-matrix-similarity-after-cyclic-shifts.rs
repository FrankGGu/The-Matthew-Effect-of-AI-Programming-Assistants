impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn matrix_similarity_after_cyclic_shifts(matrix: Vec<Vec<i32>>) -> bool {
        let rows = matrix.len();
        let cols = matrix[0].len();

        let mut row_hashes = HashSet::new();

        for row in &matrix {
            let mut hash = 0;
            for &val in row {
                hash = hash * 10 + val;
            }
            row_hashes.insert(hash);
        }

        for row in &matrix {
            let mut rotated = row.clone();
            for _ in 0..cols {
                let last = rotated.pop().unwrap();
                rotated.insert(0, last);
                let mut hash = 0;
                for &val in &rotated {
                    hash = hash * 10 + val;
                }
                if row_hashes.contains(&hash) {
                    return true;
                }
            }
        }

        false
    }
}
}