impl Solution {
    pub fn generate_matrix(n: i32) -> Vec<Vec<i32>> {
        let mut matrix = vec![vec![0; n as usize]; n as usize];
        let mut left = 0;
        let mut right = n - 1;
        let mut top = 0;
        let mut bottom = n - 1;
        let mut num = 1;

        while left <= right && top <= bottom {
            for i in left..=right {
                matrix[top as usize][i as usize] = num;
                num += 1;
            }
            top += 1;

            for i in top..=bottom {
                matrix[i as usize][right as usize] = num;
                num += 1;
            }
            right -= 1;

            if top <= bottom {
                for i in (left..=right).rev() {
                    matrix[bottom as usize][i as usize] = num;
                    num += 1;
                }
                bottom -= 1;
            }

            if left <= right {
                for i in (top..=bottom).rev() {
                    matrix[i as usize][left as usize] = num;
                    num += 1;
                }
                left += 1;
            }
        }

        matrix
    }
}