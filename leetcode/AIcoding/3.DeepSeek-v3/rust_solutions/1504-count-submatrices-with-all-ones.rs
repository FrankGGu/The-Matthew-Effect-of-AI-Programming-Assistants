impl Solution {
    pub fn num_submat(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        if m == 0 {
            return 0;
        }
        let n = mat[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut res = 0;

        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 1 {
                    if j == 0 {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = dp[i][j - 1] + 1;
                    }
                    let mut min = dp[i][j];
                    res += min;
                    for k in (0..i).rev() {
                        if dp[k][j] == 0 {
                            break;
                        }
                        min = min.min(dp[k][j]);
                        res += min;
                    }
                }
            }
        }
        res
    }
}