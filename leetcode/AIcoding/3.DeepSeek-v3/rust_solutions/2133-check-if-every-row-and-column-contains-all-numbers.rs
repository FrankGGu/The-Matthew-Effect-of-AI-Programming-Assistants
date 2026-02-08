impl Solution {
    pub fn check_valid(matrix: Vec<Vec<i32>>) -> bool {
        let n = matrix.len();
        for i in 0..n {
            let mut row_set = std::collections::HashSet::new();
            let mut col_set = std::collections::HashSet::new();
            for j in 0..n {
                if !row_set.insert(matrix[i][j]) || matrix[i][j] < 1 || matrix[i][j] > n as i32 {
                    return false;
                }
                if !col_set.insert(matrix[j][i]) || matrix[j][i] < 1 || matrix[j][i] > n as i32 {
                    return false;
                }
            }
        }
        true
    }
}