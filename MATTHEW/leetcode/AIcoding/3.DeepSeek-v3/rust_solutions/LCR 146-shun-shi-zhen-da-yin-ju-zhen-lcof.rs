impl Solution {
    pub fn spiral_order(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        if matrix.is_empty() || matrix[0].is_empty() {
            return vec![];
        }
        let (mut top, mut bottom) = (0, matrix.len() - 1);
        let (mut left, mut right) = (0, matrix[0].len() - 1);
        let mut res = Vec::new();

        while top <= bottom && left <= right {
            for j in left..=right {
                res.push(matrix[top][j]);
            }
            top += 1;

            for i in top..=bottom {
                res.push(matrix[i][right]);
            }
            if right == 0 {
                break;
            }
            right -= 1;

            if top <= bottom {
                for j in (left..=right).rev() {
                    res.push(matrix[bottom][j]);
                }
                bottom -= 1;
            }

            if left <= right {
                for i in (top..=bottom).rev() {
                    res.push(matrix[i][left]);
                }
                left += 1;
            }
        }
        res
    }
}