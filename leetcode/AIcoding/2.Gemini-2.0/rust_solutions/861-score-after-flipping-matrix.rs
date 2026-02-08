impl Solution {
    pub fn matrix_score(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut grid = grid;

        for i in 0..m {
            if grid[i][0] == 0 {
                for j in 0..n {
                    grid[i][j] = 1 - grid[i][j];
                }
            }
        }

        for j in 1..n {
            let mut count = 0;
            for i in 0..m {
                if grid[i][j] == 0 {
                    count += 1;
                }
            }
            if count > m / 2 {
                for i in 0..m {
                    grid[i][j] = 1 - grid[i][j];
                }
            }
        }

        let mut sum = 0;
        for i in 0..m {
            let mut row_val = 0;
            for j in 0..n {
                row_val = row_val * 2 + grid[i][j];
            }
            sum += row_val;
        }

        sum
    }
}