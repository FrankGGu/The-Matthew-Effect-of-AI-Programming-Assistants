struct Solution;

impl Solution {
    pub fn is_valid_sudoku(board: Vec<Vec<char>>) -> bool {
        let mut rows = vec![vec![false; 9]; 9];
        let mut cols = vec![vec![false; 9]; 9];
        let mut boxes = vec![vec![false; 9]; 9];

        for r in 0..9 {
            for c in 0..9 {
                let cell = board[r][c];
                if cell == '.' {
                    continue;
                }

                let digit = cell.to_digit(10).unwrap() as usize;
                let digit_idx = digit - 1;

                let box_idx = (r / 3) * 3 + (c / 3);

                if rows[r][digit_idx] {
                    return false;
                }
                rows[r][digit_idx] = true;

                if cols[c][digit_idx] {
                    return false;
                }
                cols[c][digit_idx] = true;

                if boxes[box_idx][digit_idx] {
                    return false;
                }
                boxes[box_idx][digit_idx] = true;
            }
        }

        true
    }
}