struct Solution;

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
            return true;
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
        word: &[char],
        k: usize,
        rows: usize,
        cols: usize,
    ) -> bool {
        if k == word.len() {
            return true;
        }

        if r >= rows || c >= cols || board[r][c] != word[k] {
            return false;
        }

        let original_char = board[r][c];
        board[r][c] = '#'; 

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
        for (dr, dc) in directions.iter() {
            let nr = r as isize + dr;
            let nc = c as isize + dc;

            if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                if Self::dfs(board, nr as usize, nc as usize, word, k + 1, rows, cols) {
                    board[r][c] = original_char; 
                    return true;
                }
            }
        }

        board[r][c] = original_char;

        false
    }
}