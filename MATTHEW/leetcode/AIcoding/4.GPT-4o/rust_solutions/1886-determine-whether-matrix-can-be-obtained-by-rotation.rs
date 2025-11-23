impl Solution {
    pub fn find_rotation(mat: Vec<Vec<i32>>, target: Vec<Vec<i32>>) -> bool {
        let n = mat.len();

        for _ in 0..4 {
            if mat == target {
                return true;
            }
            // Rotate the matrix 90 degrees clockwise
            mat = (0..n)
                .map(|i| (0..n).map(|j| mat[n - j - 1][i]).collect())
                .collect();
        }

        false
    }
}