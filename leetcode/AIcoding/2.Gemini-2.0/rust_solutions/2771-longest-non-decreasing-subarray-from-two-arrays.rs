impl Solution {
    pub fn max_non_decreasing_length(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut dp1 = vec![1; n];
        let mut dp2 = vec![1; n];
        let mut ans = 1;

        for i in 1..n {
            if nums1[i] >= nums1[i - 1] {
                dp1[i] = dp1[i].max(dp1[i - 1] + 1);
            }
            if nums1[i] >= nums2[i - 1] {
                dp1[i] = dp1[i].max(dp2[i - 1] + 1);
            }
            if nums2[i] >= nums1[i - 1] {
                dp2[i] = dp2[i].max(dp1[i - 1] + 1);
            }
            if nums2[i] >= nums2[i - 1] {
                dp2[i] = dp2[i].max(dp2[i - 1] + 1);
            }
            ans = ans.max(dp1[i].max(dp2[i]));
        }

        ans
    }
}