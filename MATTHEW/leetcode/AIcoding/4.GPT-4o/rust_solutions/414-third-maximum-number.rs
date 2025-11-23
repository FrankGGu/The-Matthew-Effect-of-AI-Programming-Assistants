impl Solution {
    pub fn third_max(nums: Vec<i32>) -> i32 {
        let mut nums_set: std::collections::HashSet<i32> = nums.into_iter().collect();
        let mut sorted_nums: Vec<i32> = nums_set.into_iter().collect();
        sorted_nums.sort_unstable();
        if sorted_nums.len() < 3 {
            return *sorted_nums.last().unwrap();
        }
        sorted_nums[sorted_nums.len() - 3]
    }
}