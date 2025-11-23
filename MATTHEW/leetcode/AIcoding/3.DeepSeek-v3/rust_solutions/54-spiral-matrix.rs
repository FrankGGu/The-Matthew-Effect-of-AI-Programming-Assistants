impl Solution {
    pub fn spiral_order(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        if matrix.is_empty() {
            return vec![];
        }
        let (mut left, mut right, mut top, mut bottom) = (0, matrix[0].len() - 1, 0, matrix.len() - 1);
        let mut res = Vec::new();
        while left <= right && top <= bottom {
            for i in left..=right {
                res.push(matrix[top][i]);
            }
            top += 1;
            if top > bottom {
                break;
            }
            for i in top..=bottom {
                res.push(matrix[i][right]);
            }
            right -= 1;
            if left > right {
                break;
            }
            for i in (left..=right).rev() {
                res.push(matrix[bottom][i]);
            }
            bottom -= 1;
            if top > bottom {
                break;
            }
            for i in (top..=bottom).rev() {
                res.push(matrix[i][left]);
            }
            left += 1;
        }
        res
    }
}