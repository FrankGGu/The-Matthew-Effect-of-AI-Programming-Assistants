impl Solution {
    pub fn ones_minus_zeros(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();

        let mut ones_row = vec![0; m];
        let mut ones_col = vec![0; n];

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    ones_row[i] += 1;
                    ones_col[j] += 1;
                }
            }
        }

        let mut diff = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                diff[i][j] = 2 * ones_row[i] + 2 * ones_col[j] - m as i32 - n as i32;
            }
        }

        diff
    }
}