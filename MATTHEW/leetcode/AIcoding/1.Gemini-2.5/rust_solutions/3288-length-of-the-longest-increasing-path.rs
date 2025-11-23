struct Solution;

impl Solution {
    fn dfs(
        row: usize,
        col: usize,
        matrix: &Vec<Vec<i32>>,
        memo: &mut Vec<Vec<i32>>,
        m: usize,
        n: usize,
    ) -> i32 {
        if memo[row][col] != 0 {
            return memo[row][col];
        }

        let mut max_len = 1;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let next_row = row as isize + dr[i];
            let next_col = col as isize + dc[i];

            if next_row >= 0
                && next_row < m as isize
                && next_col >= 0
                && next_col < n as isize
            {
                let next_row_usize = next_row as usize;
                let next_col_usize = next_col as usize;

                if matrix[next_row_usize][next_col_usize] > matrix[row][col] {
                    max_len = std::cmp::max(
                        max_len,
                        1 + Self::dfs(next_row_usize, next_col_usize, matrix, memo, m, n),
                    );
                }
            }
        }

        memo[row][col] = max_len;
        max_len
    }

    pub fn longest_increasing_path(matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let m = matrix.len();
        let n = matrix[0].len();

        let mut memo = vec![vec![0; n]; m];
        let mut overall_max_len = 0;

        for i in 0..m {
            for j in 0..n {
                overall_max_len = std::cmp::max(
                    overall_max_len,
                    Self::dfs(i, j, &matrix, &mut memo, m, n),
                );
            }
        }

        overall_max_len
    }
}