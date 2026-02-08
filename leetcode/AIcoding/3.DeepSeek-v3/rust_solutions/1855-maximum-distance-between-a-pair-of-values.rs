impl Solution {
    pub fn max_distance(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut max_dist = 0;
        let mut i = 0;
        let mut j = 0;
        let n = nums1.len();
        let m = nums2.len();

        while i < n && j < m {
            if nums1[i] > nums2[j] {
                i += 1;
            } else {
                max_dist = max_dist.max(j as i32 - i as i32);
                j += 1;
            }
        }

        max_dist
    }
}