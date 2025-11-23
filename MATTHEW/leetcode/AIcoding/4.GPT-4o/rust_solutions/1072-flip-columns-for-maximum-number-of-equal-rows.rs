use std::collections::HashMap;

impl Solution {
    pub fn max_equal_rows_after_flips(matrix: Vec<Vec<i32>>) -> i32 {
        let mut count = HashMap::new();
        let rows = matrix.len();
        let cols = matrix[0].len();

        for row in matrix {
            let key: Vec<i32> = row.iter().map(|&x| x ^ row[0]).collect();
            *count.entry(key).or_insert(0) += 1;
        }

        *count.values().max().unwrap_or(&0)
    }
}