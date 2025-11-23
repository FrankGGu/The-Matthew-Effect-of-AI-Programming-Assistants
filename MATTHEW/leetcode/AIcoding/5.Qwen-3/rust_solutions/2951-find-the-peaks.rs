struct Solution;

impl Solution {
    pub fn get_peak_elements(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let n = nums.len();

        for i in 0..n {
            let left = if i > 0 { nums[i - 1] } else { i32::MIN };
            let right = if i < n - 1 { nums[i + 1] } else { i32::MIN };

            if nums[i] > left && nums[i] > right {
                result.push(nums[i]);
            }
        }

        result
    }
}