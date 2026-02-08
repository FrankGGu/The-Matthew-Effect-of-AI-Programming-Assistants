impl Solution {
    pub fn max_side_length(mat: Vec<Vec<i32>>, threshold: i32) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut sum = vec![vec![0; n + 1]; m + 1];
        for i in 1..=m {
            for j in 1..=n {
                sum[i][j] = sum[i - 1][j] + sum[i][j - 1] - sum[i - 1][j - 1] + mat[i - 1][j - 1];
            }
        }

        let mut ans = 0;
        for k in 1..=std::cmp::min(m, n) {
            let mut found = false;
            for i in k..=m {
                for j in k..=n {
                    let cur_sum = sum[i][j] - sum[i - k][j] - sum[i][j - k] + sum[i - k][j - k];
                    if cur_sum <= threshold {
                        ans = k;
                        found = true;
                        break;
                    }
                }
                if found {
                    break;
                }
            }
        }
        ans as i32
    }
}