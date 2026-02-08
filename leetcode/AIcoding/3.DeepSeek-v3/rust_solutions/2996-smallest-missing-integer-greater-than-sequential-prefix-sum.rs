impl Solution {
    pub fn missing_integer(nums: Vec<i32>) -> i32 {
        let mut sum = nums[0];
        for i in 1..nums.len() {
            if nums[i] != nums[i - 1] + 1 {
                break;
            }
            sum += nums[i];
        }

        let mut missing = sum;
        while nums.contains(&missing) {
            missing += 1;
        }
        missing
    }
}