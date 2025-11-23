impl Solution {
    pub fn min_moves_to_capture_the_queen(r_row: i32, r_col: i32, b_row: i32, b_col: i32, q_row: i32, q_col: i32) -> i32 {
        let is_between = |val: i32, a: i32, b: i32| -> bool {
            (val > a && val < b) || (val < a && val > b)
        };

        // Check if Rook can capture Queen in 1 move
        // Rook moves horizontally or vertically. It cannot jump over the Bishop.
        let mut rook_can_capture_queen = false;

        // Case 1: Rook and Queen are on the same row
        if r_row == q_row {
            // If Bishop is not on the same row, or Bishop is on the same row but not between Rook and Queen
            if b_row != r_row || !is_between(b_col, r_col, q_col) {
                rook_can_capture_queen = true;
            }
        }

        // Case 2: Rook and Queen are on the same column
        if r_col == q_col {
            // If Bishop is not on the same column, or Bishop is on the same column but not between Rook and Queen
            if b_col != r_col || !is_between(b_row, r_row, q_row) {
                rook_can_capture_queen = true;
            }
        }

        if rook_can_capture_queen {
            return 1;
        }

        // Check if Bishop can capture Queen in 1 move
        // Bishop moves diagonally. It cannot jump over the Rook.
        let mut bishop_can_capture_queen = false;

        // Bishop and Queen are on the same diagonal if the absolute difference in their rows equals the absolute difference in their columns
        if (b_row - q_row).abs() == (b_col - q_col).abs() {
            // Check if Rook is blocking the Bishop's path to the Queen
            let rook_blocks_bishop = 
                (r_row - b_row).abs() == (r_col - b_col).abs() && // Rook is on the same diagonal as Bishop and Queen
                is_between(r_row, b_row, q_row) &&                 // Rook's row is between Bishop's and Queen's
                is_between(r_col, b_col, q_col);                   // Rook's column is between Bishop's and Queen's

            if !rook_blocks_bishop {
                bishop_can_capture_queen = true;
            }
        }

        if bishop_can_capture_queen {
            return 1;
        }

        // If neither Rook nor Bishop can capture the Queen in 1 move, it will always take 2 moves.
        2
    }
}