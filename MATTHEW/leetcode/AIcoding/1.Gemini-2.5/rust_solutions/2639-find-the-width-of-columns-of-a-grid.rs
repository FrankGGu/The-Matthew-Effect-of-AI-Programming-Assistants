impl Solution {
    pub fn find_column_width(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();

        let mut column_widths: Vec<i32> = vec![0; n];

        for j in 0..n {
            let mut max_width_for_col_j = 0;
            for i in 0..m {
                let num = grid[i][j];
                let current_width = num.to_string().len() as i32;
                max_width_for_col_j = std::cmp::max(max_width_for_col_j, current_width);
            }
            column_widths[j] = max_width_for_col_j;
        }

        column_widths
    }
}