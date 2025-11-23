impl Solution {
    pub fn restore_matrix(row_sum: Vec<i32>, col_sum: Vec<i32>) -> Vec<Vec<i32>> {
        let m = row_sum.len();
        let n = col_sum.len();

        let mut grid = vec![vec![0; n]; m];

        let mut current_row_sum = row_sum;
        let mut current_col_sum = col_sum;

        let mut i = 0;
        let mut j = 0;

        while i < m && j < n {
            let val = current_row_sum[i].min(current_col_sum[j]);
            grid[i][j] = val;

            current_row_sum[i] -= val;
            current_col_sum[j] -= val;

            if current_row_sum[i] == 0 {
                i += 1;
            }
            if current_col_sum[j] == 0 {
                j += 1;
            }
        }

        grid
    }
}