struct NumMatrix {
    prefix_sum: Vec<Vec<i32>>,
}

impl NumMatrix {
    fn new(matrix: Vec<Vec<i32>>) -> Self {
        let m = matrix.len();
        let n = if m > 0 { matrix[0].len() } else { 0 };
        let mut prefix_sum = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                prefix_sum[i][j] = matrix[i - 1][j - 1] + prefix_sum[i - 1][j] + prefix_sum[i][j - 1] - prefix_sum[i - 1][j - 1];
            }
        }

        NumMatrix { prefix_sum }
    }

    fn sum_region(&self, row1: i32, col1: i32, row2: i32, col2: i32) -> i32 {
        let r1 = row1 as usize + 1;
        let c1 = col1 as usize + 1;
        let r2 = row2 as usize + 1;
        let c2 = col2 as usize + 1;

        self.prefix_sum[r2][c2] - self.prefix_sum[r1 - 1][c2] - self.prefix_sum[r2][c1 - 1] + self.prefix_sum[r1 - 1][c1 - 1]
    }
}