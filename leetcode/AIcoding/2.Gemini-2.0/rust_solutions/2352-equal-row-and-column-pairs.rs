use std::collections::HashMap;

impl Solution {
    pub fn equal_pairs(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut row_counts: HashMap<Vec<i32>, i32> = HashMap::new();

        for row in &grid {
            *row_counts.entry(row.clone()).or_insert(0) += 1;
        }

        let mut count = 0;
        for j in 0..n {
            let mut col: Vec<i32> = Vec::new();
            for i in 0..n {
                col.push(grid[i][j]);
            }
            if let Some(&row_count) = row_counts.get(&col) {
                count += row_count;
            }
        }

        count
    }
}