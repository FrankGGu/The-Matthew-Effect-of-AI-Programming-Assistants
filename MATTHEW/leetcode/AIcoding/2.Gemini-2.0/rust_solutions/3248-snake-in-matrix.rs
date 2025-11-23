impl Solution {
    pub fn snake_matrix(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        let m = matrix.len();
        if m == 0 {
            return result;
        }
        let n = matrix[0].len();

        let mut dir = 1; // 1 for right, -1 for left

        for i in 0..m {
            if dir == 1 {
                for j in 0..n {
                    result.push(matrix[i][j]);
                }
            } else {
                for j in (0..n).rev() {
                    result.push(matrix[i][j]);
                }
            }
            dir *= -1;
        }

        result
    }
}

struct Solution;