impl Solution {
    pub fn min_moves2(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let median = nums[nums.len() / 2];
        nums.iter().map(|&x| (x - median).abs()).sum()
    }
}