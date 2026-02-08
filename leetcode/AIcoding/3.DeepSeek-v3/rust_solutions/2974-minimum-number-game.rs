impl Solution {
    pub fn number_game(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort_unstable();
        let mut res = Vec::with_capacity(nums.len());
        for i in (0..nums.len()).step_by(2) {
            if i + 1 < nums.len() {
                res.push(nums[i + 1]);
                res.push(nums[i]);
            } else {
                res.push(nums[i]);
            }
        }
        res
    }
}