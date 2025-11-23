impl Solution {
    pub fn equal_sum_grid_partition_i(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        if m == 0 {
            return false;
        }
        let n = grid[0].len();
        if n == 0 {
            return false;
        }

        let mut total_sum = 0;
        for r in 0..m {
            for c in 0..n {
                total_sum += grid[r][c];
            }
        }

        if total_sum % 2 != 0 {
            return false;
        }

        let target_sum = total_sum / 2;

        if m > 1 {
            let mut current_top_sum = 0;
            for r in 0..m - 1 {
                for c in 0..n {
                    current_top_sum += grid[r][c];
                }
                if current_top_sum == target_sum {
                    return true;
                }
            }
        }

        if n > 1 {
            let mut current_left_col_sums = vec![0; m];
            let mut total_current_left_sum = 0;
            for c in 0..n - 1 {
                for r in 0..m {
                    current_left_col_sums[r] += grid[r][c];
                }
                total_current_left_sum = current_left_col_sums.iter().sum();
                if total_current_left_sum == target_sum {
                    return true;
                }
            }
        }

        false
    }
}