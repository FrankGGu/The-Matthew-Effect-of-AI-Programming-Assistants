impl Solution {
    pub fn find_diagonal_order(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        if matrix.is_empty() || matrix[0].is_empty() {
            return Vec::new();
        }

        let m = matrix.len();
        let n = matrix[0].len();
        let mut result = Vec::with_capacity(m * n);

        let mut r = 0;
        let mut c = 0;
        let mut is_up = true; // true for up-right, false for down-left

        for _ in 0..(m * n) {
            result.push(matrix[r][c]);

            if is_up {
                // Try to move up-right
                let next_r = r as isize - 1;
                let next_c = c as isize + 1;

                if next_r < 0 || next_c >= n as isize {
                    // Hit a boundary, change direction
                    is_up = false;
                    if next_c >= n as isize { // Hit right wall (or top-right corner)
                        r += 1; // Move down
                    } else { // Hit top wall (and next_c < n)
                        c += 1; // Move right
                    }
                } else {
                    // No boundary hit, continue up-right
                    r = next_r as usize;
                    c = next_c as usize;
                }
            } else {
                // Try to move down-left
                let next_r = r as isize + 1;
                let next_c = c as isize - 1;

                if next_r >= m as isize || next_c < 0 {
                    // Hit a boundary, change direction
                    is_up = true;
                    if next_r >= m as isize { // Hit bottom wall (or bottom-left corner)
                        c += 1; // Move right
                    } else { // Hit left wall (and next_r < m)
                        r += 1; // Move down
                    }
                } else {
                    // No boundary hit, continue down-left
                    r = next_r as usize;
                    c = next_c as usize;
                }
            }
        }

        result
    }
}