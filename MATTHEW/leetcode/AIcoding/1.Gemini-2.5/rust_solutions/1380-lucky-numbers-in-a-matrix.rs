impl Solution {
    pub fn lucky_numbers (matrix: Vec<Vec<i32>>) -> Vec<i32> {
        let m = matrix.len();
        let n = matrix[0].len();

        let mut row_mins = vec![i32::MAX; m];
        let mut col_maxs = vec![i32::MIN; n];

        for i in 0..m {
            for j in 0..n {
                row_mins[i] = row_mins[i].min(matrix[i][j]);
                col_maxs[j] = col_maxs[j].max(matrix[i][j]);
            }
        }

        let mut lucky_numbers = Vec::new();
        for i in 0..m {
            for j in 0..n {
                if matrix[i][j] == row_mins[i] && matrix[i][j] == col_maxs[j] {
                    lucky_numbers.push(matrix[i][j]);
                }
            }
        }

        lucky_numbers
    }
}