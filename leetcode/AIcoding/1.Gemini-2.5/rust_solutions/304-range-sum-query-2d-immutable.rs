struct NumMatrix {
    prefix_sum: Vec<Vec<i64>>,
}

impl NumMatrix {
    fn new(matrix: Vec<Vec<i32>>) -> Self {
        if matrix.is_empty() || matrix[0].is_empty() {
            return NumMatrix { prefix_sum: vec![] };
        }

        let m = matrix.len();
        let n = matrix[0].len();

        let mut prefix_sum = vec![vec![0i64; n + 1]; m + 1];

        for r in 0..m {
            for c in 0..n {
                prefix_sum[r + 1][c + 1] = matrix[r][c] as i64
                    + prefix_sum[r][c + 1]
                    + prefix_sum[r + 1][c]
                    - prefix_sum[r][c];
            }
        }

        NumMatrix { prefix_sum }
    }

    fn sum_region(&self, row1: i32, col1: i32, row2: i32, col2: i32) -> i32 {
        let r1 = row1 as usize;
        let c1 = col1 as usize;
        let r2 = row2 as usize;
        let c2 = col2 as usize;

        let sum: i64 = self.prefix_sum[r2 + 1][c2 + 1]
            - self.prefix_sum[r1][c2 + 1]
            - self.prefix_sum[r2 + 1][c1]
            + self.prefix_sum[r1][c1];

        sum as i32
    }
}