impl Solution {
    pub fn find_median_sorted_arrays(nums1: Vec<i32>, nums2: Vec<i32>) -> f64 {
        let (m, n) = (nums1.len(), nums2.len());
        if m > n {
            return Self::find_median_sorted_arrays(nums2, nums1);
        }
        let (mut left, mut right) = (0, m);
        let (mut max_left, mut min_right) = (0, 0);
        while left <= right {
            let i = (left + right) / 2;
            let j = (m + n + 1) / 2 - i;
            let nums1_left = if i == 0 { i32::MIN } else { nums1[i - 1] };
            let nums1_right = if i == m { i32::MAX } else { nums1[i] };
            let nums2_left = if j == 0 { i32::MIN } else { nums2[j - 1] };
            let nums2_right = if j == n { i32::MAX } else { nums2[j] };
            if nums1_left <= nums2_right {
                max_left = nums1_left.max(nums2_left);
                min_right = nums1_right.min(nums2_right);
                left = i + 1;
            } else {
                right = i - 1;
            }
        }
        if (m + n) % 2 == 0 {
            (max_left as f64 + min_right as f64) / 2.0
        } else {
            max_left as f64
        }
    }
}