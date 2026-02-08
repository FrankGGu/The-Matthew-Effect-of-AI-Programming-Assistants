impl Solution {
    pub fn subset_xor_sum(nums: Vec<i32>) -> i32 {
        let mut total = 0;
        let n = nums.len();
        for mask in 0..(1 << n) {
            let mut xor = 0;
            for i in 0..n {
                if mask & (1 << i) != 0 {
                    xor ^= nums[i];
                }
            }
            total += xor;
        }
        total
    }
}