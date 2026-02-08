impl Solution {
    pub fn sorted_squares(nums: Vec<i32>) -> Vec<i32> {
        let mut result = vec![0; nums.len()];
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;

        for i in (0..nums.len()).rev() {
            if nums[left].abs() > nums[right as usize].abs() {
                result[i] = nums[left].pow(2);
                left += 1;
            } else {
                result[i] = nums[right as usize].pow(2);
                right -= 1;
            }
        }
        result
    }
}