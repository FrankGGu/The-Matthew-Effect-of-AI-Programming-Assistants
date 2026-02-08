impl Solution {
    pub fn max_side_length(mat: Vec<Vec<i32>>, threshold: i32) -> i32 {
        let rows = mat.len();
        let cols = mat[0].len();
        let mut prefix_sum = vec![vec![0; cols + 1]; rows + 1];

        for i in 1..=rows {
            for j in 1..=cols {
                prefix_sum[i][j] = mat[i - 1][j - 1] + prefix_sum[i - 1][j] + prefix_sum[i][j - 1] - prefix_sum[i - 1][j - 1];
            }
        }

        let mut side_length = 0;

        for length in 1..=rows.min(cols) {
            for i in length..=rows {
                for j in length..=cols {
                    let sum = prefix_sum[i][j] - prefix_sum[i - length][j] - prefix_sum[i][j - length] + prefix_sum[i - length][j - length];
                    if sum <= threshold {
                        side_length = length;
                    }
                }
            }
        }

        side_length
    }
}