impl Solution {
    pub fn min_flips(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut flips = 0;

        for i in 0..(n + 1) / 2 {
            for j in 0..(m + 1) / 2 {
                let mut count = 0;
                let cells = [
                    grid[i][j],
                    grid[n - 1 - i][j],
                    grid[i][m - 1 - j],
                    grid[n - 1 - i][m - 1 - j],
                ];
                for &cell in &cells {
                    count += cell;
                }
                flips += count.min(4 - count);
            }
        }
        flips
    }
}