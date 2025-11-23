impl Solution {
    pub fn kth_largest_value(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut xor = vec![vec![0; n]; m];
        let mut values = Vec::new();

        for i in 0..m {
            for j in 0..n {
                let mut val = matrix[i][j];
                if i > 0 {
                    val ^= xor[i - 1][j];
                }
                if j > 0 {
                    val ^= xor[i][j - 1];
                }
                if i > 0 && j > 0 {
                    val ^= xor[i - 1][j - 1];
                }
                xor[i][j] = val;
                values.push(val);
            }
        }

        values.sort_unstable_by(|a, b| b.cmp(a));
        values[k as usize - 1]
    }
}