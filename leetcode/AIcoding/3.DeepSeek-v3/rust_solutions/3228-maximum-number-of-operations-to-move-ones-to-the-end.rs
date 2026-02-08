impl Solution {
    pub fn maximum_number_of_operations_to_move_ones_to_end(nums: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut right = nums.len() - 1;
        let mut operations = 0;

        while left < right {
            if nums[left] == 1 {
                operations += right - left;
                right -= 1;
            } else {
                left += 1;
            }
        }

        operations as i32
    }
}