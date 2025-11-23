struct Solution;

impl Solution {
    pub fn smallest_range_i(nums: Vec<i32>, k: i32) -> i32 {
        let min_val = nums.iter().copied().fold(i32::MAX, |a, b| a.min(b));
        let max_val = nums.iter().copied().fold(i32::MIN, |a, b| a.max(b));
        (max_val - min_val).max(0) - k
    }
}