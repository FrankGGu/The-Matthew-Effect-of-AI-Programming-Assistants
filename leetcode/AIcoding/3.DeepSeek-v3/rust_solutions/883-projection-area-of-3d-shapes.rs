impl Solution {
    pub fn projection_area(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut xy = 0;
        let mut xz = 0;
        let mut yz = 0;

        for i in 0..n {
            let mut max_row = 0;
            let mut max_col = 0;
            for j in 0..n {
                if grid[i][j] > 0 {
                    xy += 1;
                }
                max_row = max_row.max(grid[i][j]);
                max_col = max_col.max(grid[j][i]);
            }
            xz += max_row;
            yz += max_col;
        }

        xy + xz + yz
    }
}