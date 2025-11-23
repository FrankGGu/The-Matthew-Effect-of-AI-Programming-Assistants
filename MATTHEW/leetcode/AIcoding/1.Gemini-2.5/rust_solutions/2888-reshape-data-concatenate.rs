impl Solution {
    pub fn get_concatenation(nums: Vec<i32>) -> Vec<i32> {
        let mut ans = Vec::with_capacity(nums.len() * 2);
        ans.extend_from_slice(&nums);
        ans.extend_from_slice(&nums);
        ans
    }
}