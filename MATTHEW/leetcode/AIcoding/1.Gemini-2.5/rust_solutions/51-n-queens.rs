struct Solution;

impl Solution {
    pub fn solve_n_queens(n: i32) -> Vec<Vec<String>> {
        let n_usize = n as usize;
        let mut solutions: Vec<Vec<String>> = Vec::new();
        let mut board: Vec<Vec<char>> = vec![vec!['.'; n_usize]; n_usize];

        let mut cols_occupied: Vec<bool> = vec![false; n_usize];
        let mut diag1_occupied: Vec<bool> = vec![false; 2 * n_usize - 1]; // row - col + n - 1
        let mut diag2_occupied: Vec<bool> = vec![false; 2 * n_usize - 1]; // row + col

        Self::backtrack(
            0,
            n_usize,
            &mut board,
            &mut cols_occupied,
            &mut diag1_occupied,
            &mut diag2_occupied,
            &mut solutions,
        );

        solutions
    }

    fn backtrack(
        row: usize,
        n: usize,
        board: &mut Vec<Vec<char>>,
        cols_occupied: &mut Vec<bool>,
        diag1_occupied: &mut Vec<bool>,
        diag2_occupied: &mut Vec<bool>,
        solutions: &mut Vec<Vec<String>>,
    ) {
        if row == n {
            let current_solution: Vec<String> = board
                .iter()
                .map(|r| r.iter().collect::<String>())
                .collect();
            solutions.push(current_solution);
            return;
        }

        for col in 0..n {
            let diag1_idx = row as i32 - col as i32 + n as i32 - 1;
            let diag2_idx = row + col;

            if !cols_occupied[col]
                && !diag1_occupied[diag1_idx as usize]
                && !diag2_occupied[diag2_idx]
            {
                board[row][col] = 'Q';
                cols_occupied[col] = true;
                diag1_occupied[diag1_idx as usize] = true;
                diag2_occupied[diag2_idx] = true;

                Self::backtrack(
                    row + 1,
                    n,
                    board,
                    cols_occupied,
                    diag1_occupied,
                    diag2_occupied,
                    solutions,
                );

                board[row][col] = '.';
                cols_occupied[col] = false;
                diag1_occupied[diag1_idx as usize] = false;
                diag2_occupied[diag2_idx] = false;
            }
        }
    }
}