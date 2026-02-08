impl Solution {
    pub fn max_increase_keeping_skyline(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut row_max = vec![0; n];
        let mut col_max = vec![0; n];

        for i in 0..n {
            for j in 0..n {
                row_max[i] = row_max[i].max(grid[i][j]);
                col_max[j] = col_max[j].max(grid[i][j]);
            }
        }

        let mut total = 0;
        for i in 0..n {
            for j in 0..n {
                total += row_max[i].min(col_max[j]) - grid[i][j];
            }
        }

        total
    }
}