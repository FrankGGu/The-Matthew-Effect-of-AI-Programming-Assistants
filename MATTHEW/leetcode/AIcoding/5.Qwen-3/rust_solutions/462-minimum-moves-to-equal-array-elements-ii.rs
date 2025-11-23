impl Solution {
    pub fn min_moves(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mid = nums.len() / 2;
        let median = nums[mid];
        nums.iter().map(|&x| (x - median).abs()).sum()
    }
}

pub struct Solution;