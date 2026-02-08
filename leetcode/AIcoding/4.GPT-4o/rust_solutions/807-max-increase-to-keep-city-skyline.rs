impl Solution {
    pub fn max_increase_keeping_skylines(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut row_max = vec![0; n];
        let mut col_max = vec![0; m];

        for i in 0..n {
            for j in 0..m {
                row_max[i] = row_max[i].max(grid[i][j]);
                col_max[j] = col_max[j].max(grid[i][j]);
            }
        }

        let mut total_increase = 0;
        for i in 0..n {
            for j in 0..m {
                total_increase += row_max[i].min(col_max[j]) - grid[i][j];
            }
        }

        total_increase
    }
}