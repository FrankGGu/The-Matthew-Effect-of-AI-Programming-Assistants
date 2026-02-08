impl Solution {
    pub fn equal_sum_grid(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut row_sum = vec![0; n];
        let mut col_sum = vec![0; n];

        for i in 0..n {
            for j in 0..n {
                row_sum[i] += grid[i][j];
                col_sum[j] += grid[i][j];
            }
        }

        let mut ans = 0;
        for i in 0..n - 1 {
            let mut row_prefix_sum = 0;
            let mut col_prefix_sum = 0;

            for j in 0..=i {
                row_prefix_sum += row_sum[j];
            }

            for k in 0..n - 1 {
                let mut temp_col_prefix_sum = 0;
                for l in 0..=k {
                    temp_col_prefix_sum += col_sum[l];
                }

                if row_prefix_sum == (row_sum.iter().sum::<i32>() - row_prefix_sum) &&
                   temp_col_prefix_sum == (col_sum.iter().sum::<i32>() - temp_col_prefix_sum) {
                    ans += 1;
                }
            }
        }

        ans
    }
}