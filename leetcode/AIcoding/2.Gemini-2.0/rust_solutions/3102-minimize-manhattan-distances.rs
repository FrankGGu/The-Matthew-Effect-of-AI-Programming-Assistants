impl Solution {
    pub fn min_total_distance(grid: Vec<Vec<i32>>) -> i32 {
        let mut rows = Vec::new();
        let mut cols = Vec::new();
        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 1 {
                    rows.push(i as i32);
                    cols.push(j as i32);
                }
            }
        }

        cols.sort();

        let row_median = rows[rows.len() / 2];
        let col_median = cols[cols.len() / 2];

        let mut distance = 0;
        for &row in &rows {
            distance += (row - row_median).abs();
        }
        for &col in &cols {
            distance += (col - col_median).abs();
        }

        distance
    }
}