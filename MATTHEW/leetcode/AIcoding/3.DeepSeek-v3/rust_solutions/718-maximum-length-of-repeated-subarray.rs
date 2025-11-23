impl Solution {
    pub fn find_length(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let m = nums1.len();
        let n = nums2.len();
        let mut dp = vec![vec![0; n + 1]; m + 1];
        let mut max_len = 0;

        for i in 1..=m {
            for j in 1..=n {
                if nums1[i - 1] == nums2[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1;
                    max_len = max_len.max(dp[i][j]);
                }
            }
        }

        max_len
    }
}