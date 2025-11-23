impl Solution {
    pub fn place_word_in_crossword(board: Vec<Vec<char>>, word: String) -> bool {
        let m = board.len();
        if m == 0 {
            return false;
        }
        let n = board[0].len();
        let word_len = word.len();
        let word_chars: Vec<char> = word.chars().collect();

        for i in 0..m {
            for j in 0..n {
                if board[i][j] == ' ' || board[i][j] == word_chars[0] {
                    // Check right
                    if j + word_len <= n {
                        let mut valid = true;
                        for k in 0..word_len {
                            if board[i][j + k] != ' ' && board[i][j + k] != word_chars[k] {
                                valid = false;
                                break;
                            }
                        }
                        if valid {
                            if (j == 0 || board[i][j - 1] == '#') && 
                               (j + word_len == n || board[i][j + word_len] == '#') {
                                return true;
                            }
                        }
                    }
                    // Check left
                    if j as i32 + 1 >= word_len as i32 {
                        let mut valid = true;
                        for k in 0..word_len {
                            if board[i][j - k] != ' ' && board[i][j - k] != word_chars[k] {
                                valid = false;
                                break;
                            }
                        }
                        if valid {
                            if (j + 1 == n || board[i][j + 1] == '#') && 
                               (j as i32 - word_len as i32 == -1 || board[i][j - word_len] == '#') {
                                return true;
                            }
                        }
                    }
                    // Check down
                    if i + word_len <= m {
                        let mut valid = true;
                        for k in 0..word_len {
                            if board[i + k][j] != ' ' && board[i + k][j] != word_chars[k] {
                                valid = false;
                                break;
                            }
                        }
                        if valid {
                            if (i == 0 || board[i - 1][j] == '#') && 
                               (i + word_len == m || board[i + word_len][j] == '#') {
                                return true;
                            }
                        }
                    }
                    // Check up
                    if i as i32 + 1 >= word_len as i32 {
                        let mut valid = true;
                        for k in 0..word_len {
                            if board[i - k][j] != ' ' && board[i - k][j] != word_chars[k] {
                                valid = false;
                                break;
                            }
                        }
                        if valid {
                            if (i + 1 == m || board[i + 1][j] == '#') && 
                               (i as i32 - word_len as i32 == -1 || board[i - word_len][j] == '#') {
                                return true;
                            }
                        }
                    }
                }
            }
        }
        false
    }
}