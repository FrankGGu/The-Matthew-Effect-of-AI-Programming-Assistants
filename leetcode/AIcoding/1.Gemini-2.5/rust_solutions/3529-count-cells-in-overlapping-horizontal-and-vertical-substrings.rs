impl Solution {
    pub fn count_cells(grid: Vec<Vec<char>>) -> i32 {
        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        if n == 0 {
            return 0;
        }

        let mut row_counts = vec![0; m];
        let mut col_counts = vec![0; n];

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 'X' {
                    row_counts[r] += 1;
                    col_counts[c] += 1;
                }
            }
        }

        let mut total_overlapping_cells = 0;
        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 'X' {
                    if row_counts[r] > 1 && col_counts[c] > 1 {
                        total_overlapping_cells += 1;
                    }
                }
            }
        }

        total_overlapping_cells
    }
}