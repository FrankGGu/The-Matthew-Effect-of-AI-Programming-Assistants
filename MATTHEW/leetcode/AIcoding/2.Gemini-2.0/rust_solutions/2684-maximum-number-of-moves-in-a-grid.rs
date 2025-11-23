impl Solution {
    pub fn max_moves(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![-1; n]; m];
        let mut ans = 0;

        fn solve(grid: &Vec<Vec<i32>>, dp: &mut Vec<Vec<i32>>, row: usize, col: usize) -> i32 {
            if dp[row][col] != -1 {
                return dp[row][col];
            }

            let m = grid.len();
            let n = grid[0].len();
            let mut max_moves = 0;

            if col + 1 < n {
                if row > 0 && grid[row - 1][col + 1] > grid[row][col] {
                    max_moves = max_moves.max(1 + solve(grid, dp, row - 1, col + 1));
                }
                if grid[row][col + 1] > grid[row][col] {
                    max_moves = max_moves.max(1 + solve(grid, dp, row, col + 1));
                }
                if row + 1 < m && grid[row + 1][col + 1] > grid[row][col] {
                    max_moves = max_moves.max(1 + solve(grid, dp, row + 1, col + 1));
                }
            }

            dp[row][col] = max_moves;
            max_moves
        }

        for i in 0..m {
            ans = ans.max(solve(&grid, &mut dp, i, 0));
        }

        ans
    }
}