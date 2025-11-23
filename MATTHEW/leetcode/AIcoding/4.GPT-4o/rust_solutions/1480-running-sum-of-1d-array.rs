impl Solution {
    pub fn running_sum(nums: Vec<i32>) -> Vec<i32> {
        let mut result = vec![0; nums.len()];
        result[0] = nums[0];
        for i in 1..nums.len() {
            result[i] = result[i - 1] + nums[i];
        }
        result
    }
}