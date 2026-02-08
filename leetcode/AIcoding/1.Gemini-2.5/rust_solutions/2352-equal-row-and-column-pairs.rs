use std::collections::HashMap;

impl Solution {
    pub fn equal_pairs(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut row_counts: HashMap<Vec<i32>, i32> = HashMap::new();
        let mut col_counts: HashMap<Vec<i32>, i32> = HashMap::new();

        for r in 0..n {
            row_counts.entry(grid[r].clone()).and_modify(|count| *count += 1).or_insert(1);
        }

        for c in 0..n {
            let mut current_col = Vec::with_capacity(n);
            for r in 0..n {
                current_col.push(grid[r][c]);
            }
            col_counts.entry(current_col).and_modify(|count| *count += 1).or_insert(1);
        }

        let mut total_pairs = 0;

        for (row_vec, row_count) in row_counts.iter() {
            if let Some(&col_count) = col_counts.get(row_vec) {
                total_pairs += row_count * col_count;
            }
        }

        total_pairs
    }
}