impl Solution {
    pub fn subset_xor_sum(nums: Vec<i32>) -> i32 {
        let mut total_xor = 0;
        let n = nums.len();

        for i in 0..(1 << n) {
            let mut current_xor = 0;
            for j in 0..n {
                if (i >> j) & 1 == 1 {
                    current_xor ^= nums[j];
                }
            }
            total_xor += current_xor;
        }

        total_xor
    }
}