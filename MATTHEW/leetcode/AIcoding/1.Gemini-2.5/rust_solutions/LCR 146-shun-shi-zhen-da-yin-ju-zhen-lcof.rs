impl Solution {
    pub fn spiral_order(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        if matrix.is_empty() || matrix[0].is_empty() {
            return Vec::new();
        }

        let mut result = Vec::new();
        let mut top = 0;
        let mut bottom = matrix.len() as i32 - 1;
        let mut left = 0;
        let mut right = matrix[0].len() as i32 - 1;

        while top <= bottom && left <= right {
            // Traverse right
            for c in left..=right {
                result.push(matrix[top as usize][c as usize]);
            }
            top += 1;
            if top > bottom {
                break;
            }

            // Traverse down
            for r in top..=bottom {
                result.push(matrix[r as usize][right as usize]);
            }
            right -= 1;
            if left > right {
                break;
            }

            // Traverse left
            for c in (left..=right).rev() {
                result.push(matrix[bottom as usize][c as usize]);
            }
            bottom -= 1;
            if top > bottom {
                break;
            }

            // Traverse up
            for r in (top..=bottom).rev() {
                result.push(matrix[r as usize][left as usize]);
            }
            left += 1;
            if left > right {
                break;
            }
        }

        result
    }
}