impl Solution {
    pub fn check_possibility(nums: Vec<i32>) -> bool {
        let mut nums = nums;
        let mut modified = false;
        for i in 0..nums.len() - 1 {
            if nums[i] > nums[i + 1] {
                if modified {
                    return false;
                }
                if i > 0 && nums[i - 1] > nums[i + 1] {
                    nums[i + 1] = nums[i];
                } else {
                    nums[i] = nums[i + 1];
                }
                modified = true;
            }
        }
        true
    }
}