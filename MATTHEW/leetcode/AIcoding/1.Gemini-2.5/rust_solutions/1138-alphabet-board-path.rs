impl Solution {
    pub fn alphabet_board_path(target: String) -> String {
        let mut result = String::new();
        let mut curr_row = 0;
        let mut curr_col = 0;

        for target_char in target.chars() {
            let char_val = (target_char as u8 - b'a') as i32;
            let next_row = char_val / 5;
            let next_col = char_val % 5;

            // Special handling for 'z'
            // If target is 'z', move L/R first, then U/D to avoid going off-board (e.g., from (4,1) to (5,1))
            if target_char == 'z' {
                let col_diff = next_col - curr_col;
                if col_diff > 0 {
                    for _ in 0..col_diff { result.push('R'); }
                } else {
                    for _ in 0..col_diff.abs() { result.push('L'); }
                }

                let row_diff = next_row - curr_row;
                if row_diff > 0 {
                    for _ in 0..row_diff { result.push('D'); }
                } else {
                    for _ in 0..row_diff.abs() { result.push('U'); }
                }
            } 
            // If current position is 'z' and target is not 'z', move U/D first, then L/R
            // This prevents trying to move R from (5,0) to (5,x) which is off-board
            else if curr_row == 5 && curr_col == 0 {
                let row_diff = next_row - curr_row;
                if row_diff > 0 {
                    for _ in 0..row_diff { result.push('D'); }
                } else {
                    for _ in 0..row_diff.abs() { result.push('U'); }
                }

                let col_diff = next_col - curr_col;
                if col_diff > 0 {
                    for _ in 0..col_diff { result.push('R'); }
                } else {
                    for _ in 0..col_diff.abs() { result.push('L'); }
                }
            } 
            // For all other cases (neither current nor target is 'z', or both are 'z'),
            // the order of U/D and L/R doesn't matter for valid moves.
            // We can use a consistent order, e.g., U/D then L/R.
            else {
                let row_diff = next_row - curr_row;
                if row_diff > 0 {
                    for _ in 0..row_diff { result.push('D'); }
                } else {
                    for _ in 0..row_diff.abs() { result.push('U'); }
                }

                let col_diff = next_col - curr_col;
                if col_diff > 0 {
                    for _ in 0..col_diff { result.push('R'); }
                } else {
                    for _ in 0..col_diff.abs() { result.push('L'); }
                }
            }

            result.push('!');
            curr_row = next_row;
            curr_col = next_col;
        }

        result
    }
}