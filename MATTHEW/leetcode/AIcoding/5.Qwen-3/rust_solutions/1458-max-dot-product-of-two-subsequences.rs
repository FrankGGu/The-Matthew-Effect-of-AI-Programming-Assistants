impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_dot_product(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let m = nums1.len();
        let n = nums2.len();
        let mut dp = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                if i == 0 && j == 0 {
                    dp[i][j] = nums1[i] * nums2[j];
                } else if i == 0 {
                    dp[i][j] = std::cmp::max(dp[i][j - 1], nums1[i] * nums2[j]);
                } else if j == 0 {
                    dp[i][j] = std::cmp::max(dp[i - 1][j], nums1[i] * nums2[j]);
                } else {
                    dp[i][j] = std::cmp::max(
                        dp[i - 1][j],
                        std::cmp::max(dp[i][j - 1], dp[i - 1][j - 1] + nums1[i] * nums2[j])
                    );
                }
            }
        }

        dp[m - 1][n - 1]
    }
}
}