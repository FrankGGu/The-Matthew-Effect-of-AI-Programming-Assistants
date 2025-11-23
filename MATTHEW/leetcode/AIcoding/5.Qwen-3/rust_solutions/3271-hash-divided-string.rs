impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn is_valid_sudoku(board: Vec<Vec<char>>) -> bool {
        let mut rows = HashMap::new();
        let mut cols = HashMap::new();
        let mut boxes = HashMap::new();

        for i in 0..9 {
            for j in 0..9 {
                let num = board[i][j];
                if num == '.' {
                    continue;
                }

                let row_key = format!("row_{}_{}", i, num);
                let col_key = format!("col_{}_{}", j, num);
                let box_key = format!("box_{}_{}_{}", i / 3, j / 3, num);

                if rows.contains_key(&row_key) || cols.contains_key(&col_key) || boxes.contains_key(&box_key) {
                    return false;
                }

                rows.insert(row_key, ());
                cols.insert(col_key, ());
                boxes.insert(box_key, ());
            }
        }

        true
    }
}
}