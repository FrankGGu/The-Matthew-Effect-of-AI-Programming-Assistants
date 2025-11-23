impl Solution {
    pub fn third_max(nums: Vec<i32>) -> i32 {
        let mut distinct_nums: Vec<i32> = nums.into_iter().collect();
        distinct_nums.sort_unstable();
        distinct_nums.dedup();

        if distinct_nums.len() >= 3 {
            distinct_nums[distinct_nums.len() - 3]
        } else {
            *distinct_nums.last().unwrap()
        }
    }
}