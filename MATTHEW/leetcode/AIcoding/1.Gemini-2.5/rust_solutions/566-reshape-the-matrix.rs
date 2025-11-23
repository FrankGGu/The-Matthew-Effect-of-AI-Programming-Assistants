impl Solution {
    pub fn matrix_reshape(mat: Vec<Vec<i32>>, r: i32, c: i32) -> Vec<Vec<i32>> {
        let m = mat.len();
        if m == 0 {
            return mat;
        }
        let n = mat[0].len();

        let total_elements = (m * n) as i32;

        if total_elements != r * c {
            return mat;
        }

        let mut new_mat = vec![vec![0; c as usize]; r as usize];
        let mut k = 0; // Linear index for elements

        for i in 0..m {
            for j in 0..n {
                let new_row = k / (c as usize);
                let new_col = k % (c as usize);
                new_mat[new_row][new_col] = mat[i][j];
                k += 1;
            }
        }

        new_mat
    }
}