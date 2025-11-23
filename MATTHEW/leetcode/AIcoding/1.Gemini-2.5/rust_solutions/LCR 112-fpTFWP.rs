impl Solution {
    pub fn longest_increasing_path(matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut dp = vec![vec![0; cols]; rows];
        let mut max_path = 0;

        for r in 0..rows {
            for c in 0..cols {
                max_path = max_path.max(Self::dfs(&matrix, r as isize, c as isize, &mut dp));
            }
        }

        max_path
    }

    fn dfs(matrix: &Vec<Vec<i32>>, r: isize, c: isize, dp: &mut Vec<Vec<i32>>) -> i32 {
        let rows = matrix.len() as isize;
        let cols = matrix[0].len() as isize;

        if dp[r as usize][c as usize] != 0 {
            return dp[r as usize][c as usize];
        }

        let mut max_len = 1;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let nr = r + dr[i];
            let nc = c + dc[i];

            if nr >= 0 && nr < rows && nc >= 0 && nc < cols && matrix[nr as usize][nc as usize] > matrix[r as usize][c as usize] {
                max_len = max_len.max(1 + Self::dfs(matrix, nr, nc, dp));
            }
        }

        dp[r as usize][c as usize] = max_len;
        max_len
    }
}