impl Solution {
    pub fn find_rotation(mat: Vec<Vec<i32>>, target: Vec<Vec<i32>>) -> bool {
        if mat == target {
            return true;
        }

        let n = mat.len();
        let mut rotated = mat.clone();

        for _ in 0..3 {
            rotated = rotate(&rotated);
            if rotated == target {
                return true;
            }
        }

        false
    }

    fn rotate(mat: &Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = mat.len();
        let mut result = vec![vec![0; n]; n];

        for i in 0..n {
            for j in 0..n {
                result[j][n - 1 - i] = mat[i][j];
            }
        }

        result
    }
}