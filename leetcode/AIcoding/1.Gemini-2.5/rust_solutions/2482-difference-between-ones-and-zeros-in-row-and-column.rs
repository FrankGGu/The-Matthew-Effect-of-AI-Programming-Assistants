impl Solution {
    pub fn ones_zeros_row_col(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
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

        let mut diff_grid = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                // onesRow[i] + onesCol[j] - zerosRow[i] - zerosCol[j]
                // We know zerosRow[i] = n - onesRow[i]
                // We know zerosCol[j] = m - onesCol[j]
                // So, diff[i][j] = onesRow[i] + onesCol[j] - (n - onesRow[i]) - (m - onesCol[j])
                //                 = onesRow[i] + onesCol[j] - n + onesRow[i] - m + onesCol[j]
                //                 = 2 * onesRow[i] + 2 * onesCol[j] - n - m
                diff_grid[i][j] = 2 * ones_row[i] + 2 * ones_col[j] - (n as i32) - (m as i32);
            }
        }

        diff_grid
    }
}