impl Solution {
    pub fn xor_all_nums(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut res = 0;
        let n = nums1.len();
        let m = nums2.len();

        if n % 2 == 1 {
            for &num in nums2.iter() {
                res ^= num;
            }
        }

        if m % 2 == 1 {
            for &num in nums1.iter() {
                res ^= num;
            }
        }

        res
    }
}