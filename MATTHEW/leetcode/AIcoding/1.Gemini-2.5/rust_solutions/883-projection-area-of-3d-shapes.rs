impl Solution {
    pub fn projection_area(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if n == 0 {
            return 0;
        }
        let m = grid[0].len();

        let mut xy_area = 0;
        let mut xz_area = 0;
        let mut yz_area = 0;

        // Calculate XY plane projection area
        for i in 0..n {
            for j in 0..m {
                if grid[i][j] > 0 {
                    xy_area += 1;
                }
            }
        }

        // Calculate XZ plane projection area (max height in each column)
        for j in 0..m {
            let mut max_height_in_col = 0;
            for i in 0..n {
                if grid[i][j] > max_height_in_col {
                    max_height_in_col = grid[i][j];
                }
            }
            xz_area += max_height_in_col;
        }

        // Calculate YZ plane projection area (max height in each row)
        for i in 0..n {
            let mut max_height_in_row = 0;
            for j in 0..m {
                if grid[i][j] > max_height_in_row {
                    max_height_in_row = grid[i][j];
                }
            }
            yz_area += max_height_in_row;
        }

        xy_area + xz_area + yz_area
    }
}