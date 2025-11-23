struct NumMatrix {
    prefix_sum: Vec<Vec<i32>>,
}

impl NumMatrix {
    fn new(matrix: Vec<Vec<i32>>) -> Self {
        let rows = matrix.len();
        if rows == 0 {
            return NumMatrix { prefix_sum: vec![] };
        }
        let cols = matrix[0].len();
        let mut prefix_sum = vec![vec![0; cols + 1]; rows + 1];
        for i in 1..=rows {
            for j in 1..=cols {
                prefix_sum[i][j] = prefix_sum[i - 1][j] + prefix_sum[i][j - 1] - prefix_sum[i - 1][j - 1] + matrix[i - 1][j - 1];
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