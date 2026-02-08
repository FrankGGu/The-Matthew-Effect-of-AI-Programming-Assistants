impl Solution {
    pub fn set_zeroes(matrix: &mut Vec<Vec<i32>>) {
        let m = matrix.len();
        if m == 0 {
            return;
        }
        let n = matrix[0].len();
        if n == 0 {
            return;
        }

        let mut first_row_has_zero = false;
        let mut first_col_has_zero = false;

        // Check if the first row needs to be zeroed
        for j in 0..n {
            if matrix[0][j] == 0 {
                first_row_has_zero = true;
                break;
            }
        }

        // Check if the first column needs to be zeroed
        for i in 0..m {
            if matrix[i][0] == 0 {
                first_col_has_zero = true;
                break;
            }
        }

        // Use the first row and first column as markers
        // Iterate from (1,1) to (m-1, n-1)
        for i in 1..m {
            for j in 1..n {
                if matrix[i][j] == 0 {
                    matrix[0][j] = 0; // Mark column j
                    matrix[i][0] = 0; // Mark row i
                }
            }
        }

        // Set elements to zero based on markers in the first row and first column
        // Iterate from (1,1) to (m-1, n-1)
        for i in 1..m {
            for j in 1..n {
                if matrix[0][j] == 0 || matrix[i][0] == 0 {
                    matrix[i][j] = 0;
                }
            }
        }

        // Apply zeroing for the first row if it originally contained a zero
        if first_row_has_zero {
            for j in 0..n {
                matrix[0][j] = 0;
            }
        }

        // Apply zeroing for the first column if it originally contained a zero
        if first_col_has_zero {
            for i in 0..m {
                matrix[i][0] = 0;
            }
        }
    }
}