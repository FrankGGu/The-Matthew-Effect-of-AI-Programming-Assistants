struct Solution;

impl Solution {
    pub fn get_concatenation(nums: Vec<i32>) -> Vec<i32> {
        let mut result = nums.clone();
        result.extend_from_slice(&nums);
        result
    }
}