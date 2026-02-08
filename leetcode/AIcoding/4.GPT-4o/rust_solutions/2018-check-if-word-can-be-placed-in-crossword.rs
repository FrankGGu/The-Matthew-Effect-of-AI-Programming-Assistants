impl Solution {
    pub fn word_can_be_placed(board: Vec<Vec<char>>, word: String) -> bool {
        let n = board.len();
        let m = board[0].len();
        let word_len = word.len();

        for i in 0..n {
            for j in 0..m {
                if board[i][j] == '#' {
                    continue;
                }
                // Check horizontally
                if j + word_len <= m {
                    let mut fit = true;
                    for k in 0..word_len {
                        if board[i][j + k] != ' ' && board[i][j + k] != word.chars().nth(k).unwrap() {
                            fit = false;
                            break;
                        }
                    }
                    if fit {
                        if (j == 0 || board[i][j - 1] == '#') && (j + word_len == m || board[i][j + word_len] == '#') {
                            return true;
                        }
                    }
                }
                // Check vertically
                if i + word_len <= n {
                    let mut fit = true;
                    for k in 0..word_len {
                        if board[i + k][j] != ' ' && board[i + k][j] != word.chars().nth(k).unwrap() {
                            fit = false;
                            break;
                        }
                    }
                    if fit {
                        if (i == 0 || board[i - 1][j] == '#') && (i + word_len == n || board[i + word_len][j] == '#') {
                            return true;
                        }
                    }
                }
            }
        }
        false
    }
}