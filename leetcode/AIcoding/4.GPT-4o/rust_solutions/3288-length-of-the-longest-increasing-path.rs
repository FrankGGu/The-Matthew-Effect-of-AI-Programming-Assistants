impl Solution {
    pub fn longest_increasing_path(matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut dp = vec![vec![-1; cols]; rows];
        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];

        fn dfs(matrix: &Vec<Vec<i32>>, dp: &mut Vec<Vec<i32>>, x: usize, y: usize) -> i32 {
            if dp[x][y] != -1 {
                return dp[x][y];
            }

            let mut max_length = 1;
            for (dx, dy) in &directions {
                let nx = (x as isize + dx) as usize;
                let ny = (y as isize + dy) as usize;
                if nx < matrix.len() && ny < matrix[0].len() && matrix[nx][ny] > matrix[x][y] {
                    max_length = max_length.max(1 + dfs(matrix, dp, nx, ny));
                }
            }
            dp[x][y] = max_length;
            max_length
        }

        let mut max_path = 0;
        for i in 0..rows {
            for j in 0..cols {
                max_path = max_path.max(dfs(&matrix, &mut dp, i, j));
            }
        }

        max_path
    }
}