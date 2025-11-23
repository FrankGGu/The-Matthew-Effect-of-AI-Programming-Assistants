impl Solution {
    pub fn number_of_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        for &num1 in &nums1 {
            for &num2 in &nums2 {
                if num1 % (num2 * k) == 0 {
                    count += 1;
                }
            }
        }
        count
    }
}