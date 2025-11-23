impl Solution {
    pub fn set_zeroes(matrix: &mut Vec<Vec<i32>>) {
        let (m, n) = (matrix.len(), matrix[0].len());
        let mut row_zero = false;

        for j in 0..n {
            if matrix[0][j] == 0 {
                row_zero = true;
            }
        }

        for i in 1..m {
            for j in 0..n {
                if matrix[i][j] == 0 {
                    matrix[0][j] = 0;
                    matrix[i][0] = 0;
                }
            }
        }

        for i in 1..m {
            for j in 1..n {
                if matrix[0][j] == 0 || matrix[i][0] == 0 {
                    matrix[i][j] = 0;
                }
            }
        }

        if row_zero {
            for j in 0..n {
                matrix[0][j] = 0;
            }
        }
    }
}