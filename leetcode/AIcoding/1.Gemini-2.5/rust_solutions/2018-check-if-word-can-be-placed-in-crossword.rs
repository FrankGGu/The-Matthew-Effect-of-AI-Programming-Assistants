impl Solution {
    pub fn place_word_in_crossword(board: Vec<Vec<char>>, word: String) -> bool {
        let m = board.len();
        let n = board[0].len();
        let word_chars: Vec<char> = word.chars().collect();
        let word_len = word_chars.len();

        fn check_segment(segment_chars: &[char], target_word_chars: &[char]) -> bool {
            if segment_chars.len() != target_word_chars.len() {
                return false;
            }
            for i in 0..target_word_chars.len() {
                if segment_chars[i] != ' ' && segment_chars[i] != target_word_chars[i] {
                    return false;
                }
            }
            true
        }

        let reversed_word_chars: Vec<char> = word_chars.iter().rev().cloned().collect();

        // Check horizontally
        for r in 0..m {
            let mut current_segment_start = 0;
            for c in 0..=n {
                if c == n || board[r][c] == '#' {
                    let segment_end = c;
                    let segment_len = segment_end - current_segment_start;

                    if segment_len == word_len {
                        let mut segment_chars_vec = Vec::with_capacity(word_len);
                        for k in 0..word_len {
                            segment_chars_vec.push(board[r][current_segment_start + k]);
                        }

                        if check_segment(&segment_chars_vec, &word_chars) {
                            return true;
                        }

                        if check_segment(&segment_chars_vec, &reversed_word_chars) {
                            return true;
                        }
                    }
                    current_segment_start = c + 1;
                }
            }
        }

        // Check vertically
        for c in 0..n {
            let mut current_segment_start = 0;
            for r in 0..=m {
                if r == m || board[r][c] == '#' {
                    let segment_end = r;
                    let segment_len = segment_end - current_segment_start;

                    if segment_len == word_len {
                        let mut segment_chars_vec = Vec::with_capacity(word_len);
                        for k in 0..word_len {
                            segment_chars_vec.push(board[current_segment_start + k][c]);
                        }

                        if check_segment(&segment_chars_vec, &word_chars) {
                            return true;
                        }

                        if check_segment(&segment_chars_vec, &reversed_word_chars) {
                            return true;
                        }
                    }
                    current_segment_start = r + 1;
                }
            }
        }

        false
    }
}