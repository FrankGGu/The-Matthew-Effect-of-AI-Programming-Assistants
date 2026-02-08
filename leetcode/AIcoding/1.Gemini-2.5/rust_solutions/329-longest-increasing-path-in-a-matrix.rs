struct Solution;

impl Solution {
    fn dfs(
        row: i32,
        col: i32,
        matrix: &Vec<Vec<i32>>,
        memo: &mut Vec<Vec<i32>>,
        rows: i32,
        cols: i32,
    ) -> i32 {
        if memo[row as usize][col as usize] != 0 {
            return memo[row as usize][col as usize];
        }

        let mut max_len = 1;
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        for (dr, dc) in directions.iter() {
            let new_row = row + dr;
            let new_col = col + dc;

            if new_row >= 0
                && new_row < rows
                && new_col >= 0
                && new_col < cols
                && matrix[new_row as usize][new_col as usize] > matrix[row as usize][col as usize]
            {
                max_len = max_len.max(1 + Self::dfs(new_row, new_col, matrix, memo, rows, cols));
            }
        }

        memo[row as usize][col as usize] = max_len;
        max_len
    }

    pub fn longest_increasing_path(matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let rows = matrix.len() as i32;
        let cols = matrix[0].len() as i32;
        let mut memo = vec![vec![0; cols as usize]; rows as usize];
        let mut overall_max_len = 0;

        for r in 0..rows {
            for c in 0..cols {
                overall_max_len = overall_max_len.max(Self::dfs(r, c, &matrix, &mut memo, rows, cols));
            }
        }

        overall_max_len
    }
}