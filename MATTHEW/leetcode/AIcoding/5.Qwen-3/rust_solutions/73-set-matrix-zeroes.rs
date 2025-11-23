impl Solution {
    pub fn set_zeroes(matrix: &mut Vec<Vec<i32>>) {
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut first_row_has_zero = false;
        let mut first_col_has_zero = false;

        for i in 0..rows {
            if matrix[i][0] == 0 {
                first_col_has_zero = true;
                break;
            }
        }

        for j in 0..cols {
            if matrix[0][j] == 0 {
                first_row_has_zero = true;
                break;
            }
        }

        for i in 1..rows {
            for j in 1..cols {
                if matrix[i][j] == 0 {
                    matrix[i][0] = 0;
                    matrix[0][j] = 0;
                }
            }
        }

        for i in 1..rows {
            if matrix[i][0] == 0 {
                for j in 1..cols {
                    matrix[i][j] = 0;
                }
            }
        }

        for j in 1..cols {
            if matrix[0][j] == 0 {
                for i in 1..rows {
                    matrix[i][j] = 0;
                }
            }
        }

        if first_row_has_zero {
            for j in 0..cols {
                matrix[0][j] = 0;
            }
        }

        if first_col_has_zero {
            for i in 0..rows {
                matrix[i][0] = 0;
            }
        }
    }
}