impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut count = 0;
        for i in 1..nums.len() {
            if nums[i] <= nums[i - 1] {
                count += nums[i - 1] - nums[i] + 1;
                nums[i] = nums[i - 1] + 1;
            }
        }
        count
    }
}