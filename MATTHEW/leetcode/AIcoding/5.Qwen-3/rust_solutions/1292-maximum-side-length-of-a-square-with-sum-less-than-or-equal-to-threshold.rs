struct Solution;

impl Solution {
    pub fn max_side_length(mat: Vec<Vec<i32>>, threshold: i32) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in 0..m {
            for j in 0..n {
                dp[i + 1][j + 1] = mat[i][j] + dp[i][j + 1] + dp[i + 1][j] - dp[i][j];
            }
        }

        let mut left = 0;
        let mut right = std::cmp::min(m, n);
        let mut ans = 0;

        while left <= right {
            let mid = (left + right) / 2;
            let mut found = false;

            for i in 0..=m - mid {
                for j in 0..=n - mid {
                    let x = i + mid;
                    let y = j + mid;
                    let sum = dp[x][y] - dp[i][y] - dp[x][j] + dp[i][j];
                    if sum <= threshold {
                        found = true;
                        break;
                    }
                }
                if found {
                    break;
                }
            }

            if found {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        ans as i32
    }
}