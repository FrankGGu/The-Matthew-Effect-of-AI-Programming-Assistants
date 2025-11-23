impl Solution {
    pub fn max_increase_keeping_skyline(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if n == 0 {
            return 0;
        }

        let mut max_row_heights = vec![0; n];
        let mut max_col_heights = vec![0; n];

        for i in 0..n {
            for j in 0..n {
                max_row_heights[i] = max_row_heights[i].max(grid[i][j]);
                max_col_heights[j] = max_col_heights[j].max(grid[i][j]);
            }
        }

        let mut total_increase = 0;

        for i in 0..n {
            for j in 0..n {
                let current_height = grid[i][j];
                let max_allowed_height = max_row_heights[i].min(max_col_heights[j]);
                total_increase += max_allowed_height - current_height;
            }
        }

        total_increase
    }
}