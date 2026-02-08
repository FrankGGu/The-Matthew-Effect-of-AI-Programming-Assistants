impl Solution {
    pub fn maximum_strong_pair_xor(nums: Vec<i32>) -> i32 {
        let mut max_xor = 0;
        let n = nums.len();
        for i in 0..n {
            for j in 0..n {
                if (nums[i] - nums[j]).abs() <= std::cmp::min(nums[i], nums[j]) {
                    max_xor = std::cmp::max(max_xor, nums[i] ^ nums[j]);
                }
            }
        }
        max_xor
    }
}