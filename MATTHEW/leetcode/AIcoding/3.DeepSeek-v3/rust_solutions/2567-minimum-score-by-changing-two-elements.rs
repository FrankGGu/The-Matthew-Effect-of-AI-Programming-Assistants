impl Solution {
    pub fn minimize_sum(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let option1 = nums[n - 1] - nums[2];
        let option2 = nums[n - 2] - nums[1];
        let option3 = nums[n - 3] - nums[0];
        option1.min(option2).min(option3)
    }
}