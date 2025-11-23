impl Solution {
    pub fn find_value_of_partition(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut min_diff = i32::MAX;

        for i in 1..nums.len() {
            min_diff = min_diff.min(nums[i] - nums[i - 1]);
        }

        min_diff
    }
}