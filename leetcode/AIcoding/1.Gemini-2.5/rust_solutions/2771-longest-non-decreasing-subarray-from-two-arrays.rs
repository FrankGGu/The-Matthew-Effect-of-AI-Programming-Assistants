impl Solution {
    pub fn max_non_decreasing_length(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        if n == 0 {
            return 0;
        }

        let mut dp0 = 1;
        let mut dp1 = 1;

        let mut max_len = 1;

        for i in 1..n {
            let mut next_dp0 = 1;
            let mut next_dp1 = 1;

            if nums1[i] >= nums1[i - 1] {
                next_dp0 = next_dp0.max(dp0 + 1);
            }
            if nums1[i] >= nums2[i - 1] {
                next_dp0 = next_dp0.max(dp1 + 1);
            }

            if nums2[i] >= nums1[i - 1] {
                next_dp1 = next_dp1.max(dp0 + 1);
            }
            if nums2[i] >= nums2[i - 1] {
                next_dp1 = next_dp1.max(dp1 + 1);
            }

            dp0 = next_dp0;
            dp1 = next_dp1;

            max_len = max_len.max(dp0).max(dp1);
        }

        max_len
    }
}