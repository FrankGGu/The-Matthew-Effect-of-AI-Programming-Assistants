impl Solution {
    pub fn count_submatrices(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut prefix_sum_grid = vec![vec![0; n]; m];
        let mut count = 0;

        for i in 0..m {
            for j in 0..n {
                let mut current_sum = grid[i][j];

                if i > 0 {
                    current_sum += prefix_sum_grid[i - 1][j];
                }
                if j > 0 {
                    current_sum += prefix_sum_grid[i][j - 1];
                }
                if i > 0 && j > 0 {
                    current_sum -= prefix_sum_grid[i - 1][j - 1];
                }

                prefix_sum_grid[i][j] = current_sum;

                if current_sum <= k {
                    count += 1;
                }
            }
        }

        count
    }
}