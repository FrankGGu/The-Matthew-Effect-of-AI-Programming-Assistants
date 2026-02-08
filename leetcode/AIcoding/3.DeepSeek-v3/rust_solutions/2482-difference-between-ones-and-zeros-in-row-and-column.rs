impl Solution {
    pub fn ones_minus_zeros(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let mut row_ones = vec![0; m];
        let mut col_ones = vec![0; n];

        for i in 0..m {
            for j in 0..n {
                row_ones[i] += grid[i][j];
                col_ones[j] += grid[i][j];
            }
        }

        let mut diff = vec![vec![0; n]; m];
        for i in 0..m {
            for j in 0..n {
                diff[i][j] = 2 * (row_ones[i] + col_ones[j]) - (m + n) as i32;
            }
        }

        diff
    }
}