struct Solution;

impl Solution {
    pub fn peaks_in_array(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        for i in 1..nums.len() - 1 {
            if nums[i] > nums[i - 1] && nums[i] > nums[i + 1] {
                result.push(i as i32);
            }
        }
        result
    }
}