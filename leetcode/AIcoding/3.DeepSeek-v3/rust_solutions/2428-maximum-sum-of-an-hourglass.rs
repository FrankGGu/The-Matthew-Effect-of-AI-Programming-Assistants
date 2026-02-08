impl Solution {
    pub fn max_sum(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut max_sum = 0;

        for i in 0..m - 2 {
            for j in 0..n - 2 {
                let current_sum = 
                    grid[i][j] + grid[i][j + 1] + grid[i][j + 2] +
                    grid[i + 1][j + 1] +
                    grid[i + 2][j] + grid[i + 2][j + 1] + grid[i + 2][j + 2];
                if current_sum > max_sum {
                    max_sum = current_sum;
                }
            }
        }

        max_sum
    }
}