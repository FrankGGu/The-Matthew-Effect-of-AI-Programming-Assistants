impl Solution {
    pub fn right_triangles(grid: Vec<Vec<i32>>) -> i64 {
        let m = grid.len();
        let n = grid[0].len();

        let mut row_counts = vec![0; m];
        let mut col_counts = vec![0; n];

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    row_counts[r] += 1;
                    col_counts[c] += 1;
                }
            }
        }

        let mut total_triangles: i64 = 0;

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    let horizontal_ones = row_counts[r] - 1;
                    let vertical_ones = col_counts[c] - 1;

                    if horizontal_ones > 0 && vertical_ones > 0 {
                        total_triangles += (horizontal_ones as i64) * (vertical_ones as i64);
                    }
                }
            }
        }

        total_triangles
    }
}