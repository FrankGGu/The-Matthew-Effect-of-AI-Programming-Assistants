impl Solution {
    pub fn number_game(mut nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        nums.sort();
        for i in (0..nums.len()).step_by(2) {
            result.push(nums[i + 1]);
            result.push(nums[i]);
        }
        result
    }
}