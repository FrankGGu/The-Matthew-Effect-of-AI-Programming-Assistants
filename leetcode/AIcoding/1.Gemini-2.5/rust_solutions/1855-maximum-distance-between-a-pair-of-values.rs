impl Solution {
    pub fn max_distance(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n1 = nums1.len();
        let n2 = nums2.len();
        let mut i: usize = 0;
        let mut j: usize = 0;
        let mut max_dist = 0;

        while i < n1 && j < n2 {
            if nums1[i] <= nums2[j] {
                max_dist = max_dist.max(j as i32 - i as i32);
                j += 1;
            } else {
                i += 1;
                j = j.max(i);
            }
        }

        max_dist
    }
}