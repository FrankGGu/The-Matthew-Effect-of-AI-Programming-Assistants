impl Solution {
    pub fn min_moves2(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let median = nums[nums.len() / 2];
        let mut moves = 0;
        for &num in &nums {
            moves += (num - median).abs();
        }
        moves
    }
}