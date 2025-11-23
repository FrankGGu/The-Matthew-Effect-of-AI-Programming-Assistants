struct Solution;

impl Solution {
    pub fn sum_of_squares(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut result = 0;
        for i in 0..n {
            if i == 0 || i == n - 1 {
                result += nums[i] * nums[i];
            }
        }
        result
    }
}