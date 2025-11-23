impl Solution {
    pub fn min_falling_path_sum(mut matrix: Vec<Vec<i32>>) -> i32 {
        let n = matrix.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return *matrix[0].iter().min().unwrap();
        }

        for r in 1..n {
            for c in 0..n {
                let mut min_prev = matrix[r - 1][c]; // Directly above
                if c > 0 {
                    min_prev = min_prev.min(matrix[r - 1][c - 1]); // Diagonally left
                }
                if c < n - 1 {
                    min_prev = min_prev.min(matrix[r - 1][c + 1]); // Diagonally right
                }
                matrix[r][c] += min_prev;
            }
        }

        *matrix[n - 1].iter().min().unwrap()
    }
}