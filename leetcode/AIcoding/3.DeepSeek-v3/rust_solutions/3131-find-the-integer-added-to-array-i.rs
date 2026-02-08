impl Solution {
    pub fn added_integer(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let min1 = nums1.iter().min().unwrap_or(&0);
        let min2 = nums2.iter().min().unwrap_or(&0);
        min2 - min1
    }
}