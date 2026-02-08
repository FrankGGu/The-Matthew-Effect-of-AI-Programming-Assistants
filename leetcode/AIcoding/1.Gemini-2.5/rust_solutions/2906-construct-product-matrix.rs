impl Solution {
    pub fn product_matrix(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let r = grid.len();
        let c = grid[0].len();
        let modulo: i64 = 12345;

        let mut result: Vec<Vec<i32>> = vec![vec![0; c]; r];

        let mut current_product: i64 = 1;
        for i in 0..r {
            for j in 0..c {
                result[i][j] = current_product as i32;
                current_product = (current_product * grid[i][j] as i64) % modulo;
            }
        }

        current_product = 1;
        for i in (0..r).rev() {
            for j in (0..c).rev() {
                result[i][j] = ((result[i][j] as i64 * current_product) % modulo) as i32;
                current_product = (current_product * grid[i][j] as i64) % modulo;
            }
        }

        result
    }
}