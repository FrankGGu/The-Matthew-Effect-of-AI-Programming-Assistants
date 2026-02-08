impl Solution {
    pub fn sorted_squares(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut left = 0;
        let mut right = n - 1;
        let mut k = n - 1;

        while left <= right {
            let left_val = nums[left];
            let right_val = nums[right];

            if left_val.abs() > right_val.abs() {
                result[k] = left_val * left_val;
                left += 1;
            } else {
                result[k] = right_val * right_val;
                right -= 1;
            }
            k -= 1;
        }

        result
    }
}