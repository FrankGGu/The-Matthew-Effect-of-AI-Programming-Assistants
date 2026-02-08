impl Solution {
    pub fn longest_increasing_path(matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }
        let (rows, cols) = (matrix.len(), matrix[0].len());
        let mut dp = vec![vec![-1; cols]; rows];

        fn dfs(matrix: &Vec<Vec<i32>>, dp: &mut Vec<Vec<i32>>, x: usize, y: usize) -> i32 {
            if dp[x][y] != -1 {
                return dp[x][y];
            }
            let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
            let mut max_length = 1;
            for (dx, dy) in directions {
                let (nx, ny) = (x as isize + dx, y as isize + dy);
                if nx >= 0 && nx < matrix.len() as isize && ny >= 0 && ny < matrix[0].len() as isize && 
                   matrix[nx as usize][ny as usize] > matrix[x][y] {
                    max_length = max_length.max(1 + dfs(matrix, dp, nx as usize, ny as usize));
                }
            }
            dp[x][y] = max_length;
            max_length
        }

        let mut longest_path = 0;
        for i in 0..rows {
            for j in 0..cols {
                longest_path = longest_path.max(dfs(&matrix, &mut dp, i, j));
            }
        }
        longest_path
    }
}