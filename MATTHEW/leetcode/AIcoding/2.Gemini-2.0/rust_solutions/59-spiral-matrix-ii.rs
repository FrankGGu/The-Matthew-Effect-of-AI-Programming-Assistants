impl Solution {
    pub fn generate_matrix(n: i32) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut matrix = vec![vec![0; n]; n];
        let mut top = 0;
        let mut bottom = n - 1;
        let mut left = 0;
        let mut right = n - 1;
        let mut num = 1;

        while num <= (n * n) as i32 {
            for i in left..=right {
                matrix[top][i] = num;
                num += 1;
            }
            top += 1;

            if num > (n * n) as i32 { break; }

            for i in top..=bottom {
                matrix[i][right] = num;
                num += 1;
            }
            right -= 1;

            if num > (n * n) as i32 { break; }

            for i in (left..=right).rev() {
                matrix[bottom][i] = num;
                num += 1;
            }
            bottom -= 1;

            if num > (n * n) as i32 { break; }

            for i in (top..=bottom).rev() {
                matrix[i][left] = num;
                num += 1;
            }
            left += 1;
        }

        matrix
    }
}