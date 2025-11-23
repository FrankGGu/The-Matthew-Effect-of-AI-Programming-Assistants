impl Solution {
    pub fn max_non_decreasing_length(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        if n == 0 {
            return 0;
        }

        let mut dp1 = 1;
        let mut dp2 = 1;
        let mut res = 1;

        for i in 1..n {
            let (mut new_dp1, mut new_dp2) = (1, 1);

            if nums1[i] >= nums1[i-1] {
                new_dp1 = new_dp1.max(dp1 + 1);
            }
            if nums1[i] >= nums2[i-1] {
                new_dp1 = new_dp1.max(dp2 + 1);
            }

            if nums2[i] >= nums1[i-1] {
                new_dp2 = new_dp2.max(dp1 + 1);
            }
            if nums2[i] >= nums2[i-1] {
                new_dp2 = new_dp2.max(dp2 + 1);
            }

            dp1 = new_dp1;
            dp2 = new_dp2;
            res = res.max(dp1.max(dp2));
        }

        res
    }
}