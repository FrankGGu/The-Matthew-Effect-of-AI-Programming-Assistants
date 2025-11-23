impl Solution {
    pub fn solve(board: &mut Vec<Vec<char>>) {
        let m = board.len();
        if m == 0 {
            return;
        }
        let n = board[0].len();
        if n == 0 {
            return;
        }

        fn dfs(board: &mut Vec<Vec<char>>, m: usize, n: usize, r: usize, c: usize) {
            if r >= m || c >= n || board[r][c] != 'O' {
                return;
            }

            board[r][c] = '#'; // Mark as visited and safe

            let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]; // (dr, dc)

            for &(dr, dc) in directions.iter() {
                let new_r = r as isize + dr;
                let new_c = c as isize + dc;

                if new_r >= 0 && new_r < m as isize && new_c >= 0 && new_c < n as isize {
                    dfs(board, m, n, new_r as usize, new_c as usize);
                }
            }
        }

        // Traverse borders and mark 'O's connected to borders as '#'
        // Top and bottom rows
        for c in 0..n {
            if board[0][c] == 'O' {
                dfs(board, m, n, 0, c);
            }
            if m > 1 && board[m - 1][c] == 'O' {
                dfs(board, m, n, m - 1, c);
            }
        }

        // Left and right columns (excluding corners already covered by top/bottom rows)
        for r in 0..m {
            if board[r][0] == 'O' {
                dfs(board, m, n, r, 0);
            }
            if n > 1 && board[r][n - 1] == 'O' {
                dfs(board, m, n, r, n - 1);
            }
        }

        // Iterate through the board to finalize changes
        for r in 0..m {
            for c in 0..n {
                if board[r][c] == 'O' {
                    // This 'O' was not reachable from the border, so it's surrounded
                    board[r][c] = 'X';
                } else if board[r][c] == '#' {
                    // This 'O' was reachable from the border, so restore it
                    board[r][c] = 'O';
                }
            }
        }
    }
}