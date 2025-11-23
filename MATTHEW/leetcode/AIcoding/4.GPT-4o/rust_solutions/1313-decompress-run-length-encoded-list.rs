impl Solution {
    pub fn decompress_rl_elist(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        for i in (0..nums.len()).step_by(2) {
            let freq = nums[i];
            let val = nums[i + 1];
            result.extend(vec![val; freq as usize]);
        }
        result
    }
}