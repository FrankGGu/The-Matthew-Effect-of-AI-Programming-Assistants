use std::collections::HashMap;

impl Solution {
    pub fn max_equal_rows_after_flips(matrix: Vec<Vec<i32>>) -> i32 {
        let mut counts: HashMap<Vec<i32>, i32> = HashMap::new();
        let mut max_count = 0;

        for row in matrix {
            let mut normalized_row = row;
            if normalized_row[0] == 1 {
                for j in 0..normalized_row.len() {
                    normalized_row[j] = 1 - normalized_row[j];
                }
            }

            *counts.entry(normalized_row).or_insert(0) += 1;
        }

        for count in counts.values() {
            max_count = max_count.max(*count);
        }

        max_count
    }
}