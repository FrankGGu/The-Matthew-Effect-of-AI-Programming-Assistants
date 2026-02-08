impl Solution {
    pub fn sorted_squares(nums: Vec<i32>) -> Vec<i32> {
        let mut result = vec![0; nums.len()];
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;
        let mut index = right;

        while left <= right {
            let left_sq = nums[left as usize].pow(2);
            let right_sq = nums[right as usize].pow(2);
            if left_sq > right_sq {
                result[index as usize] = left_sq;
                left += 1;
            } else {
                result[index as usize] = right_sq;
                right -= 1;
            }
            index -= 1;
        }

        result
    }
}