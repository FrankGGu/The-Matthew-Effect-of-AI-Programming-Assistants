impl Solution {
    pub fn find_value_of_partition(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let mut min_diff = i32::MAX;
        for i in 1..nums.len() {
            let diff = nums[i] - nums[i - 1];
            if diff < min_diff {
                min_diff = diff;
            }
        }
        min_diff
    }
}