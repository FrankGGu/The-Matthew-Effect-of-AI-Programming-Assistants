pub fn is_valid_sudoku(board: Vec<Vec<char>>) -> bool {
    let mut rows = vec![vec![0; 9]; 9];
    let mut cols = vec![vec![0; 9]; 9];
    let mut boxes = vec![vec![0; 9]; 9];

    for i in 0..9 {
        for j in 0..9 {
            if board[i][j] != '.' {
                let num = board[i][j] as usize - '1' as usize;
                let box_index = (i / 3) * 3 + j / 3;
                if rows[i][num] == 1 || cols[j][num] == 1 || boxes[box_index][num] == 1 {
                    return false;
                }
                rows[i][num] = 1;
                cols[j][num] = 1;
                boxes[box_index][num] = 1;
            }
        }
    }
    true
}