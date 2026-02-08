impl Solution {
    pub fn exist(board: Vec<Vec<char>>, word: String) -> bool {
        let rows = board.len();
        let cols = board[0].len();
        let word_chars: Vec<char> = word.chars().collect();

        for i in 0..rows {
            for j in 0..cols {
                if board[i][j] == word_chars[0] {
                    if Self::dfs(&board, &word_chars, i, j, 0) {
                        return true;
                    }
                }
            }
        }

        false
    }

    fn dfs(board: &Vec<Vec<char>>, word: &Vec<char>, row: usize, col: usize, index: usize) -> bool {
        if index == word.len() {
            return true;
        }

        if row >= board.len() || col >= board[0].len() || board[row][col] != word[index] {
            return false;
        }

        let mut new_board = board.clone();
        new_board[row][col] = '#';

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        for (dr, dc) in directions {
            let new_row = row as i32 + dr;
            let new_col = col as i32 + dc;

            if new_row >= 0 && new_row < board.len() as i32 && new_col >= 0 && new_col < board[0].len() as i32 {
                if Self::dfs(&new_board, word, new_row as usize, new_col as usize, index + 1) {
                    return true;
                }
            }
        }

        false
    }
}

struct Solution;