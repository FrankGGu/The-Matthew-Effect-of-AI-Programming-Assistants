impl Solution {
    pub fn check_valid(matrix: Vec<Vec<i32>>) -> bool {
        let n = matrix.len();
        let mut rows = vec![vec![false; n]; n];
        let mut cols = vec![vec![false; n]; n];

        for i in 0..n {
            for j in 0..n {
                let num = matrix[i][j] as usize;
                if num == 0 || num > n || rows[i][num - 1] || cols[j][num - 1] {
                    return false;
                }
                rows[i][num - 1] = true;
                cols[j][num - 1] = true;
            }
        }
        true
    }
}