impl Solution {
    pub fn check_adjacent_increasing_subarrays(nums: Vec<i32>) -> bool {
        if nums.len() <= 2 {
            return true;
        }

        for i in 0..nums.len() - 2 {
            if nums[i] < nums[i + 1] && nums[i + 1] > nums[i + 2] {
                return false;
            }
        }

        true
    }
}