impl Solution {
    pub fn can_be_equal(mat: Vec<Vec<i32>>, target: Vec<Vec<i32>>) -> bool {
        let n = mat.len();

        // Check 0 degrees rotation
        if Self::check_rotation(&mat, &target, n, 0) {
            return true;
        }

        // Check 90 degrees clockwise rotation
        if Self::check_rotation(&mat, &target, n, 1) {
            return true;
        }

        // Check 180 degrees clockwise rotation
        if Self::check_rotation(&mat, &target, n, 2) {
            return true;
        }

        // Check 270 degrees clockwise rotation
        if Self::check_rotation(&mat, &target, n, 3) {
            return true;
        }

        false
    }

    // Helper function to check if mat, after a specific rotation, matches target.
    // rotation_type: 0 for 0 deg, 1 for 90 deg clockwise, 2 for 180 deg clockwise, 3 for 270 deg clockwise.
    fn check_rotation(mat: &Vec<Vec<i32>>, target: &Vec<Vec<i32>>, n: usize, rotation_type: i32) -> bool {
        for r in 0..n {
            for c in 0..n {
                let original_val = match rotation_type {
                    0 => mat[r][c],                     // 0 degrees: (r, c) -> (r, c)
                    1 => mat[n - 1 - c][r],             // 90 degrees clockwise: (r, c) in target comes from (n-1-c, r) in mat
                    2 => mat[n - 1 - r][n - 1 - c],     // 180 degrees clockwise: (r, c) in target comes from (n-1-r, n-1-c) in mat
                    3 => mat[c][n - 1 - r],             // 270 degrees clockwise: (r, c) in target comes from (c, n-1-r) in mat
                    _ => unreachable!(),                // Should not happen with valid rotation_type
                };
                if original_val != target[r][c] {
                    return false;
                }
            }
        }
        true
    }
}