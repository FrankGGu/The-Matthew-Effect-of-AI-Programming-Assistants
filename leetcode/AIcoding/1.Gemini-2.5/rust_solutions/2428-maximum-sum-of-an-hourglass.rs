impl Solution {
    pub fn max_hourglass_sum(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut max_sum = 0;

        for r in 0..=m - 3 {
            for c in 0..=n - 3 {
                let current_sum = grid[r][c] + grid[r][c + 1] + grid[r][c + 2]
                                + grid[r + 1][c + 1]
                                + grid[r + 2][c] + grid[r + 2][c + 1] + grid[r + 2][c + 2];

                if current_sum > max_sum {
                    max_sum = current_sum;
                }
            }
        }

        max_sum
    }
}