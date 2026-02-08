impl Solution {
    pub fn matrix_block_sum(mat: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();
        let k = k as usize;

        let mut prefix_sum = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                prefix_sum[i][j] = prefix_sum[i - 1][j] + prefix_sum[i][j - 1] - prefix_sum[i - 1][j - 1] + mat[i - 1][j - 1];
            }
        }

        let mut result = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let row_start = if i >= k { i - k } else { 0 };
                let row_end = if i + k < m { i + k } else { m - 1 };
                let col_start = if j >= k { j - k } else { 0 };
                let col_end = if j + k < n { j + k } else { n - 1 };

                result[i][j] = prefix_sum[row_end + 1][col_end + 1] - prefix_sum[row_start][col_end + 1] - prefix_sum[row_end + 1][col_start] + prefix_sum[row_start][col_start];
            }
        }

        result
    }
}