impl Solution {
    pub fn minimum_area(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();

        let mut min_row = rows;
        let mut max_row = 0;
        let mut min_col = cols;
        let mut max_col = 0;

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    if i < min_row {
                        min_row = i;
                    }
                    if i > max_row {
                        max_row = i;
                    }
                    if j < min_col {
                        min_col = j;
                    }
                    if j > max_col {
                        max_col = j;
                    }
                }
            }
        }

        if min_row == rows {
            return 0;
        }

        ((max_row - min_row + 1) * (max_col - min_col + 1)) as i32
    }
}