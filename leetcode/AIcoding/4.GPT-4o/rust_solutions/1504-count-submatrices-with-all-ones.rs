impl Solution {
    pub fn num_submat(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut result = 0;

        for j in 0..n {
            for i in (0..m).rev() {
                if mat[i][j] == 1 {
                    dp[i][j] = if i == m - 1 { 1 } else { dp[i + 1][j] + 1 };
                }
            }
        }

        for i in 0..m {
            for j in 0..n {
                let mut min_height = i32::MAX;
                for k in j..n {
                    if dp[i][k] == 0 {
                        break;
                    }
                    min_height = min_height.min(dp[i][k]);
                    result += min_height;
                }
            }
        }

        result
    }
}