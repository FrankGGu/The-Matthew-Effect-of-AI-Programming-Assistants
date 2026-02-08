impl Solution {
    pub fn check_grid(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        // Condition 1: All elements in the same column must be equal.
        // grid[r][c] == grid[r+1][c] for all r from 0 to m-2, and for all c from 0 to n-1.
        for c in 0..n {
            for r in 0..m - 1 {
                if grid[r][c] != grid[r + 1][c] {
                    return false;
                }
            }
        }

        // Condition 2: All elements in the same row must be strictly increasing.
        // grid[r][c] < grid[r][c+1] for all r from 0 to m-1, and for all c from 0 to n-2.
        for r in 0..m {
            for c in 0..n - 1 {
                if grid[r][c] >= grid[r][c + 1] {
                    return false;
                }
            }
        }

        true
    }
}