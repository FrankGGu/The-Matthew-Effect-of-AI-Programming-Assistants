impl Solution {
    pub fn delete_greatest_value(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let mut sum = 0;

        for j in 0..grid[0].len() {
            let mut max_val = i32::MIN;
            for i in 0..grid.len() {
                max_val = max_val.max(grid[i][j]);
            }
            sum += max_val;

            for i in 0..grid.len() {
                grid[i].retain(|&x| x != max_val);
            }
        }
        sum
    }
}