impl Solution {
    pub fn pivot_grid(grid: Vec<Vec<i32>>, row: i32, col: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let mut result = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let new_row = (i + row as usize) % m;
                let new_col = (j + col as usize) % n;
                result[new_row][new_col] = grid[i][j];
            }
        }

        result
    }
}