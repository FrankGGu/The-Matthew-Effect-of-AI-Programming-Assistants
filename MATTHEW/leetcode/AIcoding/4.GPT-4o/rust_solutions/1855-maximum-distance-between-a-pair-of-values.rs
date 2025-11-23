impl Solution {
    pub fn max_distance(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut max_dist = 0;
        let n = nums1.len();
        let m = nums2.len();

        let mut j = 0;
        for i in 0..n {
            while j < m && nums2[j] < nums1[i] {
                j += 1;
            }
            if j < m {
                max_dist = max_dist.max(j as i32 - i as i32);
            }
        }

        max_dist
    }
}