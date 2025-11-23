impl Solution {
    pub fn delete_greatest_value(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        for row in grid.iter_mut() {
            row.sort_unstable();
        }
        let mut res = 0;
        for col in 0..grid[0].len() {
            let mut max_val = 0;
            for row in 0..grid.len() {
                max_val = max_val.max(grid[row][col]);
            }
            res += max_val;
        }
        res
    }
}