impl Solution {
    pub fn find_non_min_or_max(mut nums: Vec<i32>) -> i32 {
        if nums.len() < 3 {
            return -1;
        }
        nums.sort_unstable();
        nums[1]
    }
}