impl Solution {
    pub fn get_concatenation(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::with_capacity(nums.len() * 2);
        result.extend(&nums);
        result.extend(&nums);
        result
    }
}