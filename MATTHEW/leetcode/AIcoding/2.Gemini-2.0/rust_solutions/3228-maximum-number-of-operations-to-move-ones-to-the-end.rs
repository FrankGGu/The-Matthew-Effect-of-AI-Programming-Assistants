impl Solution {
    pub fn max_operations(nums: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut right = nums.len() - 1;
        let mut operations = 0;
        while left < right {
            if nums[left] == 1 {
                left += 1;
            } else if nums[right] == 0 {
                right -= 1;
            } else {
                nums.swap(left, right);
                operations += 1;
                left += 1;
                right -= 1;
            }
        }
        operations
    }
}