impl Solution {
    pub fn make_arrays_identical(nums1: Vec<i32>, nums2: Vec<i32>) -> i64 {
        let mut nums1 = nums1;
        let mut nums2 = nums2;
        nums1.sort();
        nums2.sort();
        let mut res = 0;
        for (a, b) in nums1.iter().zip(nums2.iter()) {
            res += (*a as i64 - *b as i64).abs();
        }
        res
    }
}