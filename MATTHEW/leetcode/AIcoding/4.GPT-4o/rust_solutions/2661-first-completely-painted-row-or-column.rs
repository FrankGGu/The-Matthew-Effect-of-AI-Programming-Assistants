use std::collections::HashMap;

impl Solution {
    pub fn first_complete_index(rows: Vec<i32>, cols: Vec<i32>) -> i32 {
        let mut row_count = HashMap::new();
        let mut col_count = HashMap::new();
        let mut complete_row = -1;
        let mut complete_col = -1;

        for (i, &row) in rows.iter().enumerate() {
            *row_count.entry(row).or_insert(0) += 1;
            if row_count[&row] == cols.len() {
                complete_row = i as i32;
            }
            *col_count.entry(cols[i]).or_insert(0) += 1;
            if col_count[&cols[i]] == rows.len() {
                complete_col = i as i32;
            }
            if complete_row != -1 || complete_col != -1 {
                break;
            }
        }

        if complete_row == -1 {
            complete_row = complete_col;
        } else if complete_col != -1 {
            complete_col = complete_row.min(complete_col);
        }

        complete_row.max(complete_col)
    }
}