impl Solution {
    pub fn is_valid_sudoku(board: Vec<Vec<char>>) -> bool {
        let mut rows = vec![vec![false; 9]; 9];
        let mut cols = vec![vec![false; 9]; 9];
        let mut boxes = vec![vec![false; 9]; 9];

        for i in 0..9 {
            for j in 0..9 {
                if board[i][j] == '.' {
                    continue;
                }
                let num = board[i][j].to_digit(10).unwrap() as usize - 1;
                let box_idx = (i / 3) * 3 + j / 3;

                if rows[i][num] || cols[j][num] || boxes[box_idx][num] {
                    return false;
                }

                rows[i][num] = true;
                cols[j][num] = true;
                boxes[box_idx][num] = true;
            }
        }
        true
    }
}