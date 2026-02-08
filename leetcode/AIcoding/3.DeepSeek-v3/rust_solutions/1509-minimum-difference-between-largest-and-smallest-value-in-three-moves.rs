impl Solution {
    pub fn min_difference(nums: Vec<i32>) -> i32 {
        if nums.len() <= 4 {
            return 0;
        }
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let option1 = nums[n - 4] - nums[0];
        let option2 = nums[n - 3] - nums[1];
        let option3 = nums[n - 2] - nums[2];
        let option4 = nums[n - 1] - nums[3];
        option1.min(option2).min(option3).min(option4)
    }
}