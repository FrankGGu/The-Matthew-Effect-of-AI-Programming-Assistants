impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn k_weakest_rows(mat: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let mut row_counts = HashMap::new();

        for (i, row) in mat.iter().enumerate() {
            let count = row.iter().sum::<i32>();
            row_counts.insert(i, count);
        }

        let mut sorted: Vec<_> = row_counts.into_iter().collect();
        sorted.sort_by(|a, b| a.1.cmp(&b.1).then_with(|| a.0.cmp(&b.0)));

        sorted.into_iter()
            .map(|(i, _)| i as i32)
            .take(k as usize)
            .collect()
    }
}
}