struct NumMatrix {
    prefix_sum: Vec<Vec<i32>>,
}

impl NumMatrix {
    fn new(matrix: Vec<Vec<i32>>) -> Self {
        let m = matrix.len();
        let n = if m == 0 { 0 } else { matrix[0].len() };
        let mut prefix_sum = vec![vec![0; n + 1]; m + 1];
        for i in 0..m {
            for j in 0..n {
                prefix_sum[i + 1][j + 1] = prefix_sum[i][j + 1] + prefix_sum[i + 1][j] - prefix_sum[i][j] + matrix[i][j];
            }
        }
        NumMatrix { prefix_sum }
    }

    fn sum_region(&self, row1: i32, col1: i32, row2: i32, col2: i32) -> i32 {
        let row1 = row1 as usize;
        let col1 = col1 as usize;
        let row2 = row2 as usize;
        let col2 = col2 as usize;
        self.prefix_sum[row2 + 1][col2 + 1] - self.prefix_sum[row1][col2 + 1] - self.prefix_sum[row2 + 1][col1] + self.prefix_sum[row1][col1]
    }
}