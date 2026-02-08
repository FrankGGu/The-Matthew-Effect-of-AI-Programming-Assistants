impl Solution {
    pub fn delete_greatest_value(mut grid: Vec<Vec<i32>>) -> i32 {
        for row in grid.iter_mut() {
            row.sort_unstable();
        }

        let mut total_sum = 0;
        if grid.is_empty() || grid[0].is_empty() {
            return 0;
        }

        let num_cols = grid[0].len();

        for col_idx in (0..num_cols).rev() {
            let mut max_val_in_step = 0;
            for row_idx in 0..grid.len() {
                max_val_in_step = max_val_in_step.max(grid[row_idx][col_idx]);
            }
            total_sum += max_val_in_step;
        }

        total_sum
    }
}