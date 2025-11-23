use std::collections::HashMap;

impl Solution {
    pub fn equal_pairs(grid: Vec<Vec<i32>>) -> i32 {
        let mut row_counts = HashMap::new();
        let n = grid.len();

        for row in grid.iter() {
            *row_counts.entry(row.to_vec()).or_insert(0) += 1;
        }

        let mut count = 0;
        for c in 0..n {
            let col: Vec<i32> = (0..n).map(|r| grid[r][c]).collect();
            count += row_counts.get(&col).unwrap_or(&0);
        }

        count
    }
}