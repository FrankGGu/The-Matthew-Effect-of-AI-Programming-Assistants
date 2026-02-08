impl Solution {
    pub fn modify_columns(matrix: &mut Vec<Vec<i32>>) {
        if matrix.is_empty() || matrix[0].is_empty() {
            return;
        }

        let rows = matrix.len();
        let cols = matrix[0].len();

        for j in 0..cols {
            let first_element_is_even = matrix[0][j] % 2 == 0;

            for i in 0..rows {
                if first_element_is_even {
                    matrix[i][j] = 0;
                } else {
                    matrix[i][j] += 1;
                }
            }
        }
    }
}