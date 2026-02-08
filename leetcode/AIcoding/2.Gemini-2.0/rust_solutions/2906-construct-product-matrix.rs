impl Solution {
    pub fn construct_product_matrix(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let mut result = vec![vec![0; n]; m];
        let modulo = 12345;

        for i in 0..m {
            for j in 0..n {
                let mut product = 1;
                for row in 0..m {
                    for col in 0..n {
                        if row != i || col != j {
                            product = (product as i64 * grid[row][col] as i64 % modulo as i64) as i32;
                        }
                    }
                }
                result[i][j] = product % modulo;
            }
        }

        result
    }
}