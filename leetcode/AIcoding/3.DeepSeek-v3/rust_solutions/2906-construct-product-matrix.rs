impl Solution {
    pub fn construct_product_matrix(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = grid.len();
        let m = grid[0].len();
        let mod_val = 12345;

        let mut prefix = vec![vec![1; m]; n];
        let mut suffix = vec![vec![1; m]; n];

        let mut product = 1;
        for i in 0..n {
            for j in 0..m {
                prefix[i][j] = product;
                product = (product as i64 * grid[i][j] as i64 % mod_val as i64) as i32;
            }
        }

        product = 1;
        for i in (0..n).rev() {
            for j in (0..m).rev() {
                suffix[i][j] = product;
                product = (product as i64 * grid[i][j] as i64 % mod_val as i64) as i32;
            }
        }

        let mut result = vec![vec![0; m]; n];
        for i in 0..n {
            for j in 0..m {
                result[i][j] = (prefix[i][j] as i64 * suffix[i][j] as i64 % mod_val as i64) as i32;
            }
        }

        result
    }
}