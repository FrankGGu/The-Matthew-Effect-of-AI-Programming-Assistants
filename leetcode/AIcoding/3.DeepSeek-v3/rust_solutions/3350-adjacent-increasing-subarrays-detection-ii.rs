impl Solution {
    pub fn can_increase(nums: Vec<i32>) -> bool {
        let mut modified = false;
        let mut prev = nums[0];

        for i in 1..nums.len() {
            if nums[i] <= prev {
                if modified {
                    return false;
                }
                modified = true;
                if i == 1 || nums[i] > nums[i - 2] {
                    prev = nums[i];
                } else {
                    prev = nums[i - 1];
                }
            } else {
                prev = nums[i];
            }
        }
        true
    }
}