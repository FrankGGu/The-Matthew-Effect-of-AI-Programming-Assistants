impl Solution {
    pub fn minimum_operations_to_write_y(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut y_counts = [0; 3];
        let mut non_y_counts = [0; 3];

        for i in 0..n {
            for j in 0..n {
                let is_y = (i == j && i <= n / 2) || (i + j == n - 1 && i <= n / 2) || (j == n / 2 && i > n / 2);
                let val = grid[i][j] as usize;
                if is_y {
                    y_counts[val] += 1;
                } else {
                    non_y_counts[val] += 1;
                }
            }
        }

        let total_y = y_counts.iter().sum::<i32>();
        let total_non_y = non_y_counts.iter().sum::<i32>();

        let mut min_operations = i32::MAX;

        for y_val in 0..3 {
            for non_y_val in 0..3 {
                if y_val == non_y_val {
                    continue;
                }
                let operations = (total_y - y_counts[y_val]) + (total_non_y - non_y_counts[non_y_val]);
                if operations < min_operations {
                    min_operations = operations;
                }
            }
        }

        min_operations
    }
}