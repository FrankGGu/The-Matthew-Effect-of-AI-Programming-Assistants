impl Solution {
    pub fn delete_greatest_value(grid: Vec<Vec<i32>>) -> i32 {
        let mut sorted_grid = grid;
        for row in &mut sorted_grid {
            row.sort();
        }

        let rows = sorted_grid.len();
        let cols = sorted_grid[0].len();

        let mut sum = 0;
        for j in 0..cols {
            let mut max_val = 0;
            for i in 0..rows {
                max_val = max_val.max(sorted_grid[i][j]);
            }
            sum += max_val;
        }

        sum
    }
}