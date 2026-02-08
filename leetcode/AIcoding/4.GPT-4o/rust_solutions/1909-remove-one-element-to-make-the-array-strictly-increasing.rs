impl Solution {
    pub fn can_be_increasing(mut nums: Vec<i32>) -> bool {
        let mut removed = false;
        for i in 1..nums.len() {
            if nums[i] <= nums[i - 1] {
                if removed {
                    return false;
                }
                removed = true;
                if i > 1 && nums[i] <= nums[i - 2] {
                    nums[i] = nums[i - 1];
                }
            }
        }
        true
    }
}