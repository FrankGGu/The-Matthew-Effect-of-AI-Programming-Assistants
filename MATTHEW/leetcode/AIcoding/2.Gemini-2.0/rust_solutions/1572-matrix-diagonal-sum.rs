impl Solution {
    pub fn diagonal_sum(mat: Vec<Vec<i32>>) -> i32 {
        let n = mat.len();
        let mut sum = 0;
        for i in 0..n {
            sum += mat[i][i];
            sum += mat[i][n - 1 - i];
        }
        if n % 2 == 1 {
            sum -= mat[n / 2][n / 2];
        }
        sum
    }
}