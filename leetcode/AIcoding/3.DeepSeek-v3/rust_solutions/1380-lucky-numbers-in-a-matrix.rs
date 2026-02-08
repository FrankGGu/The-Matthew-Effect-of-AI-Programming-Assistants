impl Solution {
    pub fn lucky_numbers(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut row_min = vec![std::i32::MAX; m];
        let mut col_max = vec![std::i32::MIN; n];

        for i in 0..m {
            for j in 0..n {
                row_min[i] = row_min[i].min(matrix[i][j]);
                col_max[j] = col_max[j].max(matrix[i][j]);
            }
        }

        let mut result = Vec::new();
        for i in 0..m {
            for j in 0..n {
                if matrix[i][j] == row_min[i] && matrix[i][j] == col_max[j] {
                    result.push(matrix[i][j]);
                }
            }
        }

        result
    }
}