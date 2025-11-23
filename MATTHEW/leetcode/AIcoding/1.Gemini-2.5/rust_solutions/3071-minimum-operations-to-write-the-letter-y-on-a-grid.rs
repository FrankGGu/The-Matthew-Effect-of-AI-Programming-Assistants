impl Solution {
    pub fn minimum_operations(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mid = n / 2;

        let mut y_counts = [0; 10];
        let mut other_counts = [0; 10];
        let mut total_y_cells = 0;
        let mut total_other_cells = 0;

        for r in 0..n {
            for c in 0..n {
                let is_y_cell = (r <= mid && (c == r || c == n - 1 - r)) || (r > mid && c == mid);

                if is_y_cell {
                    y_counts[grid[r][c] as usize] += 1;
                    total_y_cells += 1;
                } else {
                    other_counts[grid[r][c] as usize] += 1;
                    total_other_cells += 1;
                }
            }
        }

        let mut min_ops = n * n; // Maximum possible operations

        for y_val in 0..10 {
            for other_val in 0..10 {
                if y_val == other_val {
                    continue;
                }

                let current_ops = (total_y_cells - y_counts[y_val as usize]) + 
                                  (total_other_cells - other_counts[other_val as usize]);

                min_ops = min_ops.min(current_ops);
            }
        }

        min_ops as i32
    }
}