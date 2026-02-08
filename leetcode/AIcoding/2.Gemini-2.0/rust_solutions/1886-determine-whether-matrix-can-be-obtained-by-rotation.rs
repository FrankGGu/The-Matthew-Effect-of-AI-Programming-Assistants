impl Solution {
    pub fn find_rotation(mat: Vec<Vec<i32>>, target: Vec<Vec<i32>>) -> bool {
        let n = mat.len();
        for _ in 0..4 {
            if mat == target {
                return true;
            }
            let mut rotated = vec![vec![0; n]; n];
            for i in 0..n {
                for j in 0..n {
                    rotated[j][n - 1 - i] = mat[i][j];
                }
            }
            mat.clone_from(&rotated);
        }
        false
    }
}