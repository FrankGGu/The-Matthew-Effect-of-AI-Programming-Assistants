impl Solution {
    pub fn kth_largest_value(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();

        let mut xor_values = Vec::with_capacity(m * n);
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                dp[i][j] = matrix[i - 1][j - 1] ^ dp[i - 1][j] ^ dp[i][j - 1] ^ dp[i - 1][j - 1];
                xor_values.push(dp[i][j]);
            }
        }

        xor_values.sort_unstable_by(|a, b| b.cmp(a));
        xor_values[(k - 1) as usize]
    }
}