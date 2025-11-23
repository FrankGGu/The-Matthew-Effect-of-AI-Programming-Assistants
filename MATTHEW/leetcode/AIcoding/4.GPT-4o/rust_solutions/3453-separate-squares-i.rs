pub fn separate_squares(nums: &mut Vec<i32>) {
    let mut left = 0;
    let mut right = nums.len() - 1;

    while left < right {
        while left < right && nums[left] >= 0 {
            left += 1;
        }
        while left < right && nums[right] < 0 {
            right -= 1;
        }
        if left < right {
            nums.swap(left, right);
        }
    }
}