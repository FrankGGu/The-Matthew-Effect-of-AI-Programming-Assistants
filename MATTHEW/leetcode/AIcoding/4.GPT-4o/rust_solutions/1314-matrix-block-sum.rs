impl Solution {
    pub fn matrix_block_sum(mat: Vec<Vec<i32>>, K: i32) -> Vec<Vec<i32>> {
        let (m, n) = (mat.len(), mat[0].len());
        let mut prefix_sum = vec![vec![0; n + 1]; m + 1];

        for i in 0..m {
            for j in 0..n {
                prefix_sum[i + 1][j + 1] = mat[i][j] + prefix_sum[i][j + 1] + prefix_sum[i + 1][j] - prefix_sum[i][j];
            }
        }

        let mut result = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let r1 = (i as i32 - K).max(0) as usize;
                let r2 = (i as i32 + K).min((m - 1) as i32) as usize;
                let c1 = (j as i32 - K).max(0) as usize;
                let c2 = (j as i32 + K).min((n - 1) as i32) as usize;

                result[i][j] = prefix_sum[r2 + 1][c2 + 1] - prefix_sum[r1][c2 + 1] - prefix_sum[r2 + 1][c1] + prefix_sum[r1][c1];
            }
        }

        result
    }
}