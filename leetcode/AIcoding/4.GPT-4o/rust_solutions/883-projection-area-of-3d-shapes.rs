impl Solution {
    pub fn projection_area(grid: Vec<Vec<i32>>) -> i32 {
        let mut xy = 0;
        let mut xz = 0;
        let mut yz = 0;

        for row in &grid {
            for &val in row {
                if val > 0 {
                    xy += 1;
                }
                xz = xz.max(val);
            }
        }

        for col in 0..grid[0].len() {
            let mut max_in_col = 0;
            for row in &grid {
                max_in_col = max_in_col.max(row[col]);
            }
            yz += max_in_col;
        }

        xy + xz + yz
    }
}