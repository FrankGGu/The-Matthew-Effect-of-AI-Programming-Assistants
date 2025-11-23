impl Solution {
    pub fn max_sum_after_placement(board: Vec<Vec<i32>>, rooks: Vec<Vec<i32>>) -> i64 {
        let m = board.len();
        let n = board[0].len();
        let mut max_sum = i64::min_value();

        for i in 0..3 {
            for j in 0..3 {
                if i == j {
                    continue;
                }
                for k in 0..3 {
                    if k == i || k == j {
                        continue;
                    }

                    let mut temp_board = board.clone();
                    let mut current_sum: i64 = 0;

                    let rook1_row = rooks[0][0] as usize;
                    let rook1_col = rooks[0][1] as usize;
                    let rook2_row = rooks[1][0] as usize;
                    let rook2_col = rooks[1][1] as usize;
                    let rook3_row = rooks[2][0] as usize;
                    let rook3_col = rooks[2][1] as usize;

                    let new_rook1_row = rooks[i][0] as usize;
                    let new_rook1_col = rooks[i][1] as usize;
                    let new_rook2_row = rooks[j][0] as usize;
                    let new_rook2_col = rooks[j][1] as usize;
                    let new_rook3_row = rooks[k][0] as usize;
                    let new_rook3_col = rooks[k][1] as usize;

                    let mut row_taken = vec![false; m];
                    let mut col_taken = vec![false; n];

                    row_taken[new_rook1_row] = true;
                    col_taken[new_rook1_col] = true;
                    row_taken[new_rook2_row] = true;
                    col_taken[new_rook2_col] = true;
                    row_taken[new_rook3_row] = true;
                    col_taken[new_rook3_col] = true;

                    for r in 0..m {
                        for c in 0..n {
                            if row_taken[r] || col_taken[c] {
                                current_sum += temp_board[r][c] as i64;
                            }
                        }
                    }

                    max_sum = max_sum.max(current_sum);
                }
            }
        }

        max_sum
    }
}