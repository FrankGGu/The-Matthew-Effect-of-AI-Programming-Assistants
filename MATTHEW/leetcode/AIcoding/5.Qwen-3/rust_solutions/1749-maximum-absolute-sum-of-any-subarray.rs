struct Solution;

impl Solution {
    pub fn max_absolute_sum(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut max_abs = 0;
        let mut current_sum = 0;

        for i in 0..k {
            current_sum += nums[i];
        }

        max_abs = current_sum.abs();

        for i in k..n {
            current_sum += nums[i] - nums[i - k];
            max_abs = std::cmp::max(max_abs, current_sum.abs());
        }

        max_abs
    }
}