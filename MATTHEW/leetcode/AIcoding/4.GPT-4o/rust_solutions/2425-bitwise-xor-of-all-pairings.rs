impl Solution {
    pub fn xor_all_nums(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let len1 = nums1.len();
        let len2 = nums2.len();

        let mut result = 0;

        if len1 % 2 == 1 && len2 % 2 == 1 {
            for &num in &nums1 {
                result ^= num;
            }
            for &num in &nums2 {
                result ^= num;
            }
        } else if len1 % 2 == 1 {
            for &num in &nums1 {
                result ^= num;
            }
        } else if len2 % 2 == 1 {
            for &num in &nums2 {
                result ^= num;
            }
        }

        result
    }
}