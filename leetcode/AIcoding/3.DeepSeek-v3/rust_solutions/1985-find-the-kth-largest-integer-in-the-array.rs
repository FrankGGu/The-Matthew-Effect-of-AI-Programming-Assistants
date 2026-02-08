use std::cmp::Ordering;

impl Solution {
    pub fn kth_largest_number(nums: Vec<String>, k: i32) -> String {
        let mut nums = nums;
        nums.sort_by(|a, b| {
            if a.len() != b.len() {
                a.len().cmp(&b.len())
            } else {
                a.cmp(b)
            }
        });
        nums[nums.len() - k as usize].clone()
    }
}