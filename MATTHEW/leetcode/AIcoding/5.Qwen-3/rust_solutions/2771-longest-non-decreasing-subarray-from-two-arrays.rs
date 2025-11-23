pub fn max_non_decreasing_length(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
    let n = nums1.len();
    let mut dp1 = 0;
    let mut dp2 = 0;
    let mut max_len = 0;

    for i in 0..n {
        let mut new_dp1 = 0;
        let mut new_dp2 = 0;

        if i == 0 {
            new_dp1 = 1;
            new_dp2 = 1;
        } else {
            if nums1[i] >= nums1[i - 1] {
                new_dp1 = dp1 + 1;
            }
            if nums1[i] >= nums2[i - 1] {
                new_dp1 = new_dp1.max(dp2 + 1);
            }

            if nums2[i] >= nums1[i - 1] {
                new_dp2 = dp1 + 1;
            }
            if nums2[i] >= nums2[i - 1] {
                new_dp2 = new_dp2.max(dp2 + 1);
            }
        }

        dp1 = new_dp1;
        dp2 = new_dp2;
        max_len = max_len.max(dp1).max(dp2);
    }

    max_len
}