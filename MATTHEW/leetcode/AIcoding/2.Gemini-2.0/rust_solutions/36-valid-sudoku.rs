impl Solution {
    pub fn is_valid_sudoku(board: Vec<Vec<char>>) -> bool {
        let mut rows: [u16; 9] = [0; 9];
        let mut cols: [u16; 9] = [0; 9];
        let mut boxes: [u16; 9] = [0; 9];

        for i in 0..9 {
            for j in 0..9 {
                if board[i][j] != '.' {
                    let digit = 1 << (board[i][j] as u8 - b'1');
                    let box_index = (i / 3) * 3 + j / 3;

                    if (rows[i] & digit) > 0 || (cols[j] & digit) > 0 || (boxes[box_index] & digit) > 0 {
                        return false;
                    }

                    rows[i] |= digit;
                    cols[j] |= digit;
                    boxes[box_index] |= digit;
                }
            }
        }

        true
    }
}