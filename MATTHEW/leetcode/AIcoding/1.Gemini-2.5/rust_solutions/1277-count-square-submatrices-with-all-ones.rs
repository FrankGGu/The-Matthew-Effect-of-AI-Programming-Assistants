impl Solution {
    pub fn count_squares(mut matrix: Vec<Vec<i32>>) -> i32 {
        let m = matrix.len();
        if m == 0 {
            return 0;
        }
        let n = matrix[0].len();
        if n == 0 {
            return 0;
        }

        let mut total_squares = 0;

        for i in 0..m {
            for j in 0..n {
                if matrix[i][j] == 1 && i > 0 && j > 0 {
                    matrix[i][j] = 1 + std::cmp::min(
                        matrix[i-1][j],
                        std::cmp::min(matrix[i][j-1], matrix[i-1][j-1])
                    );
                }
                total_squares += matrix[i][j];
            }
        }

        total_squares
    }
}