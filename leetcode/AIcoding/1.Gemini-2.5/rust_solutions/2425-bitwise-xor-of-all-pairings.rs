impl Solution {
    pub fn xor_all_pairings(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n1 = nums1.len();
        let n2 = nums2.len();

        let mut xor_sum1 = 0;
        for &num in &nums1 {
            xor_sum1 ^= num;
        }

        let mut xor_sum2 = 0;
        for &num in &nums2 {
            xor_sum2 ^= num;
        }

        let mut result = 0;

        if n1 % 2 == 1 {
            result ^= xor_sum2;
        }

        if n2 % 2 == 1 {
            result ^= xor_sum1;
        }

        result
    }
}