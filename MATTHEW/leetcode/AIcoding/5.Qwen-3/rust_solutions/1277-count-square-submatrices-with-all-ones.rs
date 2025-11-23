struct Solution;

impl Solution {
    pub fn count_squares(mut matrix: Vec<Vec<i32>>) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut count = 0;

        for i in 0..m {
            for j in 0..n {
                if matrix[i][j] == 1 {
                    if i == 0 || j == 0 {
                        count += 1;
                    } else {
                        let min_val = matrix[i-1][j-1].min(matrix[i-1][j]).min(matrix[i][j-1]);
                        matrix[i][j] = min_val + 1;
                        count += matrix[i][j];
                    }
                }
            }
        }

        count
    }
}