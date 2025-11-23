impl Solution {
    pub fn place_word_in_crossword(board: Vec<Vec<char>>, word: String) -> bool {
        let m = board.len();
        let n = board[0].len();
        let word_len = word.len();
        let word_chars: Vec<char> = word.chars().collect();

        for i in 0..m {
            for j in 0..n {
                if board[i][j] == '#' {
                    continue;
                }

                // Check horizontal
                if j + word_len <= n {
                    let mut valid_forward = true;
                    for k in 0..word_len {
                        if board[i][j + k] != ' ' && board[i][j + k] != word_chars[k] {
                            valid_forward = false;
                            break;
                        }
                    }
                    if valid_forward {
                        if j + word_len == n || board[i][j + word_len] == '#' {
                            if j == 0 || board[i][j - 1] == '#' {
                                return true;
                            }
                        }
                    }
                }

                if j >= word_len - 1 {
                    let mut valid_backward = true;
                    for k in 0..word_len {
                        if board[i][j - k] != ' ' && board[i][j - k] != word_chars[k] {
                            valid_backward = false;
                            break;
                        }
                    }
                    if valid_backward {
                        if j - word_len == -1 || board[i][j - word_len] == '#' {
                            if j == n - 1 || board[i][j + 1] == '#' {
                                return true;
                            }
                        }
                    }
                }

                // Check vertical
                if i + word_len <= m {
                    let mut valid_forward = true;
                    for k in 0..word_len {
                        if board[i + k][j] != ' ' && board[i + k][j] != word_chars[k] {
                            valid_forward = false;
                            break;
                        }
                    }
                    if valid_forward {
                        if i + word_len == m || board[i + word_len][j] == '#' {
                            if i == 0 || board[i - 1][j] == '#' {
                                return true;
                            }
                        }
                    }
                }

                if i >= word_len - 1 {
                    let mut valid_backward = true;
                    for k in 0..word_len {
                        if board[i - k][j] != ' ' && board[i - k][j] != word_chars[k] {
                            valid_backward = false;
                            break;
                        }
                    }
                    if valid_backward {
                        if i - word_len == -1 || board[i - word_len][j] == '#' {
                            if i == m - 1 || board[i + 1][j] == '#' {
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