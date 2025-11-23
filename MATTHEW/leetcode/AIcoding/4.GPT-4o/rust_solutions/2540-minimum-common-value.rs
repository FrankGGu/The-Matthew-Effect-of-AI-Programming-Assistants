impl Solution {
    pub fn get_common(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let set1: std::collections::HashSet<_> = nums1.into_iter().collect();
        for num in nums2 {
            if set1.contains(&num) {
                return num;
            }
        }
        -1
    }
}