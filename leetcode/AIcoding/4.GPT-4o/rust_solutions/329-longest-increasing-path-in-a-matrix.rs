impl Solution {
    pub fn longest_increasing_path(matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let (rows, cols) = (matrix.len(), matrix[0].len());
        let mut dp = vec![vec![0; cols]; rows];
        let mut max_length = 0;
        let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

        fn dfs(matrix: &Vec<Vec<i32>>, dp: &mut Vec<Vec<i32>>, x: usize, y: usize, directions: &Vec<(i32, i32)>) -> i32 {
            if dp[x][y] != 0 {
                return dp[x][y];
            }
            let mut max_path = 1;
            for &(dx, dy) in directions {
                let (nx, ny) = (x as i32 + dx, y as i32 + dy);
                if nx >= 0 && nx < matrix.len() as i32 && ny >= 0 && ny < matrix[0].len() as i32 && matrix[nx as usize][ny as usize] > matrix[x][y] {
                    max_path = max_path.max(1 + dfs(matrix, dp, nx as usize, ny as usize, directions));
                }
            }
            dp[x][y] = max_path;
            max_path
        }

        for i in 0..rows {
            for j in 0..cols {
                max_length = max_length.max(dfs(&matrix, &mut dp, i, j, &directions));
            }
        }

        max_length
    }
}