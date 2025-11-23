struct Solution;

impl Solution {
    pub fn matrix_reshape(mat: Vec<Vec<i32>>, r: i32, c: i32) -> Vec<Vec<i32>> {
        let rows = mat.len();
        let cols = mat[0].len();
        if rows * cols != r as usize * c as usize {
            return mat;
        }

        let mut result = vec![vec![0; c as usize]; r as usize];
        for i in 0..rows {
            for j in 0..cols {
                let idx = i * cols + j;
                let row = idx / c as usize;
                let col = idx % c as usize;
                result[row][col] = mat[i][j];
            }
        }

        result
    }
}