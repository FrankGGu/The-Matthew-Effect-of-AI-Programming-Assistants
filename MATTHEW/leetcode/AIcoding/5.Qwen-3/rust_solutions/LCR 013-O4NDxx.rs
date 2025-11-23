struct NumMatrix {
    prefix: Vec<Vec<i32>>,
}

impl NumMatrix {
    fn new(matrix: Vec<Vec<i32>>) -> Self {
        let rows = matrix.len();
        let cols = if rows > 0 { matrix[0].len() } else { 0 };
        let mut prefix = vec![vec![0; cols + 1]; rows + 1];
        for i in 0..rows {
            for j in 0..cols {
                prefix[i + 1][j + 1] = matrix[i][j] + prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j];
            }
        }
        NumMatrix { prefix }
    }

    fn sum_region(&self, row1: i32, col1: i32, row2: i32, col2: i32) -> i32 {
        let r1 = row1 as usize;
        let c1 = col1 as usize;
        let r2 = row2 as usize;
        let c2 = col2 as usize;
        self.prefix[r2 + 1][c2 + 1] - self.prefix[r1][c2 + 1] - self.prefix[r2 + 1][c1] + self.prefix[r1][c1]
    }
}