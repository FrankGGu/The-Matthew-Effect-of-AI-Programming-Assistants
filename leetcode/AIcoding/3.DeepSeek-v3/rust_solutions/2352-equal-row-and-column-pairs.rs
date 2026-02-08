use std::collections::HashMap;

impl Solution {
    pub fn equal_pairs(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut row_counts = HashMap::new();

        for row in &grid {
            *row_counts.entry(row).or_insert(0) += 1;
        }

        let mut count = 0;
        for c in 0..n {
            let mut col = Vec::with_capacity(n);
            for r in 0..n {
                col.push(grid[r][c]);
            }
            if let Some(&cnt) = row_counts.get(&col) {
                count += cnt;
            }
        }

        count
    }
}