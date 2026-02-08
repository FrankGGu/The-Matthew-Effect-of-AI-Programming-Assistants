impl Solution {
    pub fn find_length(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n1 = nums1.len();
        let n2 = nums2.len();
        let mut dp = vec![vec![0; n2 + 1]; n1 + 1];
        let mut max_len = 0;

        for i in 1..=n1 {
            for j in 1..=n2 {
                if nums1[i - 1] == nums2[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1;
                    if dp[i][j] > max_len {
                        max_len = dp[i][j];
                    }
                } else {
                    dp[i][j] = 0;
                }
            }
        }

        max_len
    }
}