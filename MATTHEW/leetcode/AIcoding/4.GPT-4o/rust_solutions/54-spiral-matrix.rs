impl Solution {
    pub fn spiral_order(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        if matrix.is_empty() || matrix[0].is_empty() {
            return Vec::new();
        }

        let (mut top, mut bottom) = (0, matrix.len() as i32 - 1);
        let (mut left, mut right) = (0, matrix[0].len() as i32 - 1);
        let mut result = Vec::new();

        while top <= bottom && left <= right {
            for i in left..=right {
                result.push(matrix[top as usize][i as usize]);
            }
            top += 1;

            for i in top..=bottom {
                result.push(matrix[i as usize][right as usize]);
            }
            right -= 1;

            if top <= bottom {
                for i in (left..=right).rev() {
                    result.push(matrix[bottom as usize][i as usize]);
                }
                bottom -= 1;
            }

            if left <= right {
                for i in (top..=bottom).rev() {
                    result.push(matrix[i as usize][left as usize]);
                }
                left += 1;
            }
        }

        result
    }
}