impl Solution {
    pub fn concatenate(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut result = nums1.clone();
        result.extend(nums2);
        result
    }
}