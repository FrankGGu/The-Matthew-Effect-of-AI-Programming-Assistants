impl Solution {
    pub fn projection_area(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut xy_area = 0;
        let mut xz_area = 0;
        let mut yz_area = 0;

        for i in 0..n {
            let mut max_row = 0;
            let mut max_col = 0;
            for j in 0..n {
                if grid[i][j] > 0 {
                    xy_area += 1;
                }
                max_row = max_row.max(grid[i][j]);
                max_col = max_col.max(grid[j][i]);
            }
            xz_area += max_row;
            yz_area += max_col;
        }

        xy_area + xz_area + yz_area
    }
}