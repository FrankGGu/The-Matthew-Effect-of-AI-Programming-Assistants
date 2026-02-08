impl Solution {
    pub fn maximum_strong_pair_xor(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_xor = 0;
        for i in 0..n {
            for j in 0..n {
                if (nums[i] - nums[j]).abs() <= nums[i].min(nums[j]) {
                    max_xor = max_xor.max(nums[i] ^ nums[j]);
                }
            }
        }
        max_xor
    }
}