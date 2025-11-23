impl Solution {
    pub fn has_trailing_zeros(nums: Vec<i32>) -> bool {
        let or_result: i32 = nums.iter().fold(0, |acc, &x| acc | x);
        or_result & 1 == 0
    }
}