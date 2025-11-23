impl Solution {
    pub fn modified_matrix(matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut max_col = vec![0; n];

        for j in 0..n {
            let mut max_val = i32::MIN;
            for i in 0..m {
                if matrix[i][j] > max_val {
                    max_val = matrix[i][j];
                }
            }
            max_col[j] = max_val;
        }

        let mut res = matrix;
        for i in 0..m {
            for j in 0..n {
                if res[i][j] == -1 {
                    res[i][j] = max_col[j];
                }
            }
        }

        res
    }
}