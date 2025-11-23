impl Solution {
    pub fn spiral_order(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        if matrix.is_empty() {
            return vec![];
        }

        let mut result = vec![];
        let mut top = 0;
        let mut bottom = matrix.len() - 1;
        let mut left = 0;
        let mut right = matrix[0].len() - 1;
        let mut dir = 0; // 0: right, 1: down, 2: left, 3: up

        while top <= bottom && left <= right {
            match dir {
                0 => {
                    for i in left..=right {
                        result.push(matrix[top][i]);
                    }
                    top += 1;
                }
                1 => {
                    for i in top..=bottom {
                        result.push(matrix[i][right]);
                    }
                    right -= 1;
                }
                2 => {
                    for i in (left..=right).rev() {
                        result.push(matrix[bottom][i]);
                    }
                    bottom -= 1;
                }
                3 => {
                    for i in (top..=bottom).rev() {
                        result.push(matrix[i][left]);
                    }
                    left += 1;
                }
                _ => {}
            }
            dir = (dir + 1) % 4;
        }

        result
    }
}