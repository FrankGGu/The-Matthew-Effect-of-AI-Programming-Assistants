impl Solution {
    pub fn make_square(matrix: Vec<Vec<i32>>) -> i32 {
        let n = matrix.len();
        let mut ans = 4;

        for i in 0..n {
            for j in 0..n {
                if matrix[i][j] == matrix[0][0] {
                    continue;
                }

                let mut count = 0;
                if matrix[i][0] != matrix[0][0] {
                    count += 1;
                }
                if matrix[i][n - 1] != matrix[0][0] {
                    count += 1;
                }
                if matrix[0][j] != matrix[0][0] {
                    count += 1;
                }
                if matrix[n - 1][j] != matrix[0][0] {
                    count += 1;
                }

                ans = ans.min(count);
            }
        }

        ans
    }
}