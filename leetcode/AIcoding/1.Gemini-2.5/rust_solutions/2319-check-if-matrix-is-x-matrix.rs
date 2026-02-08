impl Solution {
    pub fn check_x_matrix(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();
        for r in 0..n {
            for c in 0..n {
                if r == c || r + c == n - 1 {
                    // Element should be non-zero
                    if grid[r][c] == 0 {
                        return false;
                    }
                } else {
                    // Element should be zero
                    if grid[r][c] != 0 {
                        return false;
                    }
                }
            }
        }
        true
    }
}