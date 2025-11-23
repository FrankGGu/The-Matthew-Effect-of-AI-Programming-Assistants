impl Solution {
    pub fn construct_matrix(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();
        let mut row = vec![1; m];
        let mut col = vec![1; n];

        for i in 0..m {
            for j in 0..n {
                if mat[i][j] != 0 {
                    row[i] = 0;
                    col[j] = 0;
                }
            }
        }

        let mut result = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                result[i][j] = row[i] | col[j];
            }
        }

        result
    }
}