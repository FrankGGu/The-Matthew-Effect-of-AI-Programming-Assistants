use std::collections::HashSet;

impl Solution {
    pub fn minimum_moves(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut total_stones = 0;

        for i in 0..n {
            for j in 0..m {
                total_stones += grid[i][j];
            }
        }

        let target = total_stones / (n * m);
        let mut moves = 0;

        for i in 0..n {
            for j in 0..m {
                if grid[i][j] > target {
                    moves += grid[i][j] - target;
                }
            }
        }

        moves
    }
}