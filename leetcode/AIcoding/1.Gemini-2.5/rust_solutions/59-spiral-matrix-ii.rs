impl Solution {
    pub fn generate_spiral_matrix(n: i32) -> Vec<Vec<i32>> {
        if n == 0 {
            return vec![];
        }

        let n_usize = n as usize;
        let mut matrix = vec![vec![0; n_usize]; n_usize];

        let mut top = 0;
        let mut bottom = n - 1;
        let mut left = 0;
        let mut right = n - 1;

        let mut num = 1;

        while top <= bottom && left <= right {
            // Traverse right
            for c in left..=right {
                matrix[top as usize][c as usize] = num;
                num += 1;
            }
            top += 1;

            // Traverse down
            for r in top..=bottom {
                matrix[r as usize][right as usize] = num;
                num += 1;
            }
            right -= 1;

            // Traverse left (if there's still a row)
            if top <= bottom {
                for c in (left..=right).rev() {
                    matrix[bottom as usize][c as usize] = num;
                    num += 1;
                }
                bottom -= 1;
            }

            // Traverse up (if there's still a column)
            if left <= right {
                for r in (top..=bottom).rev() {
                    matrix[r as usize][left as usize] = num;
                    num += 1;
                }
                left += 1;
            }
        }

        matrix
    }
}