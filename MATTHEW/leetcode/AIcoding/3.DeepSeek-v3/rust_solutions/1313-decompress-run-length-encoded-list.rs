impl Solution {
    pub fn decompress_rl_elist(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut i = 0;
        while i < nums.len() {
            let freq = nums[i];
            let val = nums[i + 1];
            for _ in 0..freq {
                result.push(val);
            }
            i += 2;
        }
        result
    }
}