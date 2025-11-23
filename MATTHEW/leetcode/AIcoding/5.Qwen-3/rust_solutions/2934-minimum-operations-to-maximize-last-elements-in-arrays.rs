struct Solution;

impl Solution {
    pub fn min_operations(mut nums1: Vec<i32>, mut nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let m = nums2.len();

        if n == 0 || m == 0 {
            return 0;
        }

        let mut ops = 0;

        for i in (0..n).rev() {
            if nums1[i] > nums2[i] {
                nums1[i] = nums1[i] - nums2[i];
                nums2[i] = nums2[i] + nums1[i];
                ops += 1;
            }
        }

        for i in (0..m).rev() {
            if nums2[i] > nums1[i] {
                nums2[i] = nums2[i] - nums1[i];
                nums1[i] = nums1[i] + nums2[i];
                ops += 1;
            }
        }

        ops
    }
}