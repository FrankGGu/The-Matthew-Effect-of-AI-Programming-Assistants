impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn is_valid_sudoku(board: &[Vec<char>]) -> bool {
        let mut rows = vec![HashSet::new(); 9];
        let mut cols = vec![HashSet::new(); 9];
        let mut boxes = vec![HashSet::new(); 9];

        for i in 0..9 {
            for j in 0..9 {
                let cell = board[i][j];
                if cell == '.' {
                    continue;
                }

                if rows[i].contains(&cell) {
                    return false;
                }
                rows[i].insert(cell);

                if cols[j].contains(&cell) {
                    return false;
                }
                cols[j].insert(cell);

                let box_idx = (i / 3) * 3 + j / 3;
                if boxes[box_idx].contains(&cell) {
                    return false;
                }
                boxes[box_idx].insert(cell);
            }
        }

        true
    }
}
}