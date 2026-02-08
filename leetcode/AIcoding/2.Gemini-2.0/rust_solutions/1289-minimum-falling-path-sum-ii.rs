impl Solution {
    pub fn min_falling_path_sum(matrix: Vec<Vec<i32>>) -> i32 {
        let n = matrix.len();
        let mut dp = matrix[0].clone();

        for i in 1..n {
            let mut new_dp = vec![0; n];
            for j in 0..n {
                let mut min_val = i32::MAX;
                for k in 0..n {
                    if k != j {
                        min_val = min_val.min(dp[k]);
                    }
                }
                new_dp[j] = min_val + matrix[i][j];
            }
            dp = new_dp;
        }

        *dp.iter().min().unwrap()
    }
}