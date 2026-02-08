impl Solution {
    pub fn modified_matrix(matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut result = matrix.clone();
        let mut max_cols: Vec<i32> = vec![-1; n];

        for j in 0..n {
            for i in 0..m {
                max_cols[j] = max_cols[j].max(matrix[i][j]);
            }
        }

        for i in 0..m {
            for j in 0..n {
                if result[i][j] == -1 {
                    result[i][j] = max_cols[j];
                }
            }
        }

        result
    }
}