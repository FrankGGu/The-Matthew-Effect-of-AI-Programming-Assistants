impl Solution {
    pub fn find_diagonal_order(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        if matrix.is_empty() {
            return vec![];
        }

        let m = matrix.len();
        let n = matrix[0].len();
        let mut result = Vec::with_capacity(m * n);
        let mut row = 0;
        let mut col = 0;
        let mut up = true;

        for _ in 0..(m * n) {
            result.push(matrix[row][col]);

            if up {
                if row - 1 >= 0 && col + 1 < n {
                    row -= 1;
                    col += 1;
                } else {
                    if col + 1 < n {
                        col += 1;
                    } else {
                        row += 1;
                    }
                    up = false;
                }
            } else {
                if row + 1 < m && col - 1 >= 0 {
                    row += 1;
                    col -= 1;
                } else {
                    if row + 1 < m {
                        row += 1;
                    } else {
                        col += 1;
                    }
                    up = true;
                }
            }
        }

        result
    }
}