impl Solution {
    pub fn solve_n_queens(n: i32) -> Vec<Vec<String>> {
        let n = n as usize;
        let mut board = vec![vec!['.'; n]; n];
        let mut result: Vec<Vec<String>> = Vec::new();
        let mut cols = vec![false; n];
        let mut diag1 = vec![false; 2 * n - 1];
        let mut diag2 = vec![false; 2 * n - 1];

        fn backtrack(row: usize, board: &mut Vec<Vec<char>>, result: &mut Vec<Vec<String>>, cols: &mut Vec<bool>, diag1: &mut Vec<bool>, diag2: &mut Vec<bool>, n: usize) {
            if row == n {
                let solution: Vec<String> = board.iter().map(|row| row.iter().collect()).collect();
                result.push(solution);
                return;
            }

            for col in 0..n {
                if cols[col] || diag1[row + col] || diag2[row + n - 1 - col] {
                    continue;
                }

                board[row][col] = 'Q';
                cols[col] = true;
                diag1[row + col] = true;
                diag2[row + n - 1 - col] = true;

                backtrack(row + 1, board, result, cols, diag1, diag2, n);

                board[row][col] = '.';
                cols[col] = false;
                diag1[row + col] = false;
                diag2[row + n - 1 - col] = false;
            }
        }

        backtrack(0, &mut board, &mut result, &mut cols, &mut diag1, &mut diag2, n);
        result
    }
}