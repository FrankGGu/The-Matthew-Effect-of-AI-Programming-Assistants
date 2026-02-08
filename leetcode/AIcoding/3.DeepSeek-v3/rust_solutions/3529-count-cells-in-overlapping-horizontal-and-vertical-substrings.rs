impl Solution {
    pub fn count_cells(grid: Vec<Vec<char>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        let mut row_counts = vec![0; rows];
        let mut col_counts = vec![0; cols];

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == '1' {
                    row_counts[i] += 1;
                    col_counts[j] += 1;
                }
            }
        }

        let mut count = 0;
        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == '1' && (row_counts[i] > 1 || col_counts[j] > 1) {
                    count += 1;
                }
            }
        }

        count
    }
}