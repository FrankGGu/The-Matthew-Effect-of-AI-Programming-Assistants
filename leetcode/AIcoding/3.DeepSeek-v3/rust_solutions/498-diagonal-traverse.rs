impl Solution {
    pub fn find_diagonal_order(mat: Vec<Vec<i32>>) -> Vec<i32> {
        if mat.is_empty() || mat[0].is_empty() {
            return vec![];
        }
        let m = mat.len();
        let n = mat[0].len();
        let mut result = Vec::with_capacity(m * n);
        let mut i = 0;
        let mut j = 0;
        let mut up = true;

        while result.len() < m * n {
            result.push(mat[i][j]);
            if up {
                if j == n - 1 {
                    i += 1;
                    up = false;
                } else if i == 0 {
                    j += 1;
                    up = false;
                } else {
                    i -= 1;
                    j += 1;
                }
            } else {
                if i == m - 1 {
                    j += 1;
                    up = true;
                } else if j == 0 {
                    i += 1;
                    up = true;
                } else {
                    i += 1;
                    j -= 1;
                }
            }
        }
        result
    }
}