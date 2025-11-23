impl Solution {
    pub fn number_game(mut nums: Vec<i32>) -> Vec<i32> {
        nums.sort_unstable();
        let mut result = Vec::with_capacity(nums.len());
        for i in (0..nums.len()).step_by(2) {
            result.push(nums[i + 1]);
            result.push(nums[i]);
        }
        result
    }
}