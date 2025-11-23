impl Solution {
    pub fn check_x_matrix(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();
        for i in 0..n {
            for j in 0..n {
                if (i == j || i + j == n - 1) && grid[i][j] == 0 {
                    return false;
                }
                if (i != j && i + j != n - 1) && grid[i][j] != 0 {
                    return false;
                }
            }
        }
        true
    }
}