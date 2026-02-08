impl Solution {
    pub fn diagonal_sum(mat: Vec<Vec<i32>>) -> i32 {
        let n = mat.len();
        let mut total_sum = 0;

        for i in 0..n {
            total_sum += mat[i][i]; // Primary diagonal element

            // Secondary diagonal element, ensuring it's not the same as the primary diagonal element
            // (which happens only for the center element of an odd-sized matrix)
            if i != n - 1 - i {
                total_sum += mat[i][n - 1 - i];
            }
        }
        total_sum
    }
}