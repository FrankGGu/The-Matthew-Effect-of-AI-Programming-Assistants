impl Solution {
    pub fn minimum_area(grid: Vec<Vec<i32>>) -> i32 {
        let mut min_row = grid.len();
        let mut max_row = 0;
        let mut min_col = grid[0].len();
        let mut max_col = 0;

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 1 {
                    min_row = min_row.min(i);
                    max_row = max_row.max(i);
                    min_col = min_col.min(j);
                    max_col = max_col.max(j);
                }
            }
        }

        if max_row < min_row || max_col < min_col {
            0
        } else {
            ((max_row - min_row + 1) * (max_col - min_col + 1)) as i32
        }
    }
}