impl Solution {
    pub fn max_dot_product(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let m = nums2.len();
        let mut dp = vec![vec![i32::MIN; m + 1]; n + 1];

        for i in 1..=n {
            for j in 1..=m {
                dp[i][j] = dp[i - 1][j - 1].max(nums1[i - 1] * nums2[j - 1]).max(dp[i][j - 1]).max(dp[i - 1][j]);
            }
        }

        dp[n][m]
    }
}