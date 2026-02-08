impl Solution {
    pub fn subset_xor_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let total_subsets = 1 << n;
        let mut total_xor_sum = 0;

        for i in 0..total_subsets {
            let mut subset_xor = 0;
            for j in 0..n {
                if i & (1 << j) != 0 {
                    subset_xor ^= nums[j];
                }
            }
            total_xor_sum += subset_xor;
        }

        total_xor_sum
    }
}