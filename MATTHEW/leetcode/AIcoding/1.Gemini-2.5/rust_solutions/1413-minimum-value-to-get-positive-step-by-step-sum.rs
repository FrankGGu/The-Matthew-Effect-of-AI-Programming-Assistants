struct Solution;

impl Solution {
    pub fn min_start_value(nums: Vec<i32>) -> i32 {
        let mut current_sum = 0;
        let mut min_prefix_sum = 0;

        for num in nums {
            current_sum += num;
            min_prefix_sum = min_prefix_sum.min(current_sum);
        }

        (1 - min_prefix_sum).max(1)
    }
}