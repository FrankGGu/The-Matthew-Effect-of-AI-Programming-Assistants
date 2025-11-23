impl Solution {
    pub fn exist(mut board: Vec<Vec<char>>, word: String) -> bool {
        let rows = board.len();
        if rows == 0 {
            return false;
        }
        let cols = board[0].len();
        if cols == 0 {
            return false;
        }

        let word_chars: Vec<char> = word.chars().collect();
        if word_chars.is_empty() {
            return true; // An empty word is considered to exist
        }

        for r in 0..rows {
            for c in 0..cols {
                if board[r][c] == word_chars[0] {
                    if Self::dfs(&mut board, r, c, &word_chars, 0, rows, cols) {
                        return true;
                    }
                }
            }
        }
        false
    }

    fn dfs(
        board: &mut Vec<Vec<char>>,
        r: usize,
        c: usize,
        word_chars: &[char],
        k: usize,
        rows: usize,
        cols: usize,
    ) -> bool {
        if k == word_chars.len() {
            return true;
        }

        if r >= rows || c >= cols || board[r][c] != word_chars[k] {
            return false;
        }

        let original_char = board[r][c];
        board[r][c] = '#'; // Mark as visited

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let nr = r as isize + dr[i];
            let nc = c as isize + dc[i];

            if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                if Self::dfs(
                    board,
                    nr as usize,
                    nc as usize,
                    word_chars,
                    k + 1,
                    rows,
                    cols,
                ) {
                    board[r][c] = original_char; // Backtrack
                    return true;
                }
            }
        }

        board[r][c] = original_char; // Backtrack
        false
    }
}