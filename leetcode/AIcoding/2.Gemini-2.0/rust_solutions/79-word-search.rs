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

        let rows = board.len();
        let cols = board[0].len();

        if row >= rows || col >= cols || board[row][col] != word[index] {
            return false;
        }

        let mut new_board = board.clone();
        new_board[row][col] = '#';

        let up = if row > 0 {
            Self::dfs(&new_board, word, row - 1, col, index + 1)
        } else {
            false
        };
        let down = if row < rows - 1 {
            Self::dfs(&new_board, word, row + 1, col, index + 1)
        } else {
            false
        };
        let left = if col > 0 {
            Self::dfs(&new_board, word, row, col - 1, index + 1)
        } else {
            false
        };
        let right = if col < cols - 1 {
            Self::dfs(&new_board, word, row, col + 1, index + 1)
        } else {
            false
        };

        up || down || left || right
    }
}