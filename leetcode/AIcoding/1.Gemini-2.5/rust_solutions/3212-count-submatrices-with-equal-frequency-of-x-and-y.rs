impl Solution {
    pub fn count_submatrices(grid: Vec<Vec<char>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut dp_x = vec![vec![0; n + 1]; m + 1];
        let mut dp_y = vec![vec![0; n + 1]; m + 1];

        let mut count = 0;

        for i in 1..=m {
            for j in 1..=n {
                dp_x[i][j] = dp_x[i - 1][j] + dp_x[i][j - 1] - dp_x[i - 1][j - 1];
                dp_y[i][j] = dp_y[i - 1][j] + dp_y[i][j - 1] - dp_y[i - 1][j - 1];

                match grid[i - 1][j - 1] {
                    'X' => dp_x[i][j] += 1,
                    'Y' => dp_y[i][j] += 1,
                    _ => {}
                }

                if dp_x[i][j] == dp_y[i][j] && dp_x[i][j] > 0 {
                    count += 1;
                }
            }
        }

        count
    }
}