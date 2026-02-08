impl Solution {
    pub fn find_rotation(mat: Vec<Vec<i32>>, target: Vec<Vec<i32>>) -> bool {
        let n = mat.len();
        let mut rotated = vec![vec![0; n]; n];
        let mut same = true;

        for _ in 0..4 {
            same = true;
            for i in 0..n {
                for j in 0..n {
                    rotated[j][n - 1 - i] = mat[i][j];
                }
            }
            for i in 0..n {
                for j in 0..n {
                    if rotated[i][j] != target[i][j] {
                        same = false;
                        break;
                    }
                }
                if !same {
                    break;
                }
            }
            if same {
                return true;
            }
            let mat = rotated.clone();
        }
        false
    }
}