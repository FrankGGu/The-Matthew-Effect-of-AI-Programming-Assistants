impl Solution {
    pub fn modify_matrix(mut matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = matrix.len();
        let n = matrix[0].len();

        for i in 0..m {
            let mut current_row_max = 0;
            for j in 0..n {
                if matrix[i][j] > current_row_max {
                    current_row_max = matrix[i][j];
                }
            }

            for j in 0..n {
                if matrix[i][j] == -1 {
                    matrix[i][j] = current_row_max;
                }
            }
        }

        matrix
    }
}