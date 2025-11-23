struct NumMatrix {
    sum: Vec<Vec<i32>>,
}

impl NumMatrix {
    fn new(matrix: Vec<Vec<i32>>) -> Self {
        let m = matrix.len();
        let n = if m > 0 { matrix[0].len() } else { 0 };
        let mut sum = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                sum[i][j] = sum[i - 1][j] + sum[i][j - 1] - sum[i - 1][j - 1] + matrix[i - 1][j - 1];
            }
        }

        NumMatrix { sum }
    }

    fn sum_region(&self, row1: i32, col1: i32, row2: i32, col2: i32) -> i32 {
        let row1 = row1 as usize + 1;
        let col1 = col1 as usize + 1;
        let row2 = row2 as usize + 1;
        let col2 = col2 as usize + 1;

        self.sum[row2][col2] - self.sum[row1 - 1][col2] - self.sum[row2][col1 - 1] + self.sum[row1 - 1][col1 - 1]
    }
}