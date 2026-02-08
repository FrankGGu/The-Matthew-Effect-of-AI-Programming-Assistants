impl Solution {
    pub fn exist(board: Vec<Vec<char>>, word: String) -> bool {
        let mut board = board;
        let rows = board.len();
        let cols = board[0].len();
        let word_chars: Vec<char> = word.chars().collect();

        for r in 0..rows {
            for c in 0..cols {
                if board[r][c] == word_chars[0] {
                    if Self::dfs(&mut board, r as i32, c as i32, &word_chars, 0, rows as i32, cols as i32) {
                        return true;
                    }
                }
            }
        }
        false
    }

    fn dfs(
        board: &mut Vec<Vec<char>>,
        r: i32,
        c: i32,
        word_chars: &[char],
        k: usize,
        rows: i32,
        cols: i32,
    ) -> bool {
        if k == word_chars.len() {
            return true;
        }

        if r < 0 || r >= rows || c < 0 || c >= cols || board[r as usize][c as usize] != word_chars[k] {
            return false;
        }

        let original_char = board[r as usize][c as usize];
        board[r as usize][c as usize] = '#';

        let found = Self::dfs(board, r + 1, c, word_chars, k + 1, rows, cols)
            || Self::dfs(board, r - 1, c, word_chars, k + 1, rows, cols)
            || Self::dfs(board, r, c + 1, word_chars, k + 1, rows, cols)
            || Self::dfs(board, r, c - 1, word_chars, k + 1, rows, cols);

        board[r as usize][c as usize] = original_char;

        found
    }
}