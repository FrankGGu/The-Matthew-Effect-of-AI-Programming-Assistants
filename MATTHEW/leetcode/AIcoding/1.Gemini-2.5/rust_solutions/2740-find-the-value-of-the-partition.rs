impl Solution {
    pub fn find_value_of_partition(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let mut min_diff = i32::MAX;
        for i in 0..nums.len() - 1 {
            min_diff = min_diff.min(nums[i + 1] - nums[i]);
        }
        min_diff
    }
}