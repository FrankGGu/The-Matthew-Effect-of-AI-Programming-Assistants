impl Solution {
    pub fn find_diagonal_order(mat: Vec<Vec<i32>>) -> Vec<i32> {
        if mat.is_empty() || mat[0].is_empty() {
            return vec![];
        }

        let m = mat.len();
        let n = mat[0].len();
        let mut result = Vec::with_capacity(m * n);
        let mut row = 0;
        let mut col = 0;
        let mut up = true;

        while row < m && col < n {
            result.push(mat[row][col]);
            if up {
                if col == n - 1 {
                    row += 1;
                    up = false;
                } else if row == 0 {
                    col += 1;
                    up = false;
                } else {
                    row -= 1;
                    col += 1;
                }
            } else {
                if row == m - 1 {
                    col += 1;
                    up = true;
                } else if col == 0 {
                    row += 1;
                    up = true;
                } else {
                    row += 1;
                    col -= 1;
                }
            }
        }

        result
    }
}