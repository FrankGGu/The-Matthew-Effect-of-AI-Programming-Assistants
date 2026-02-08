impl Solution {
    pub fn matrix_reshape(mat: Vec<Vec<i32>>, r: i32, c: i32) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();
        let r = r as usize;
        let c = c as usize;

        if m * n != r * c {
            return mat;
        }

        let mut reshaped = vec![vec![0; c]; r];
        let mut k = 0;

        for i in 0..m {
            for j in 0..n {
                reshaped[k / c][k % c] = mat[i][j];
                k += 1;
            }
        }

        reshaped
    }
}