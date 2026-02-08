impl Solution {
    pub fn maximum_value_after_reverse(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_value = nums.iter().cloned().sum::<i32>();
        let mut max_diff = 0;

        for i in 0..n - 1 {
            max_diff = max_diff.max((nums[i] - nums[i + 1]).abs());
        }

        for i in 0..n {
            if i > 0 {
                max_diff = max_diff.max((nums[i] - nums[0]).abs());
            }
            if i < n - 1 {
                max_diff = max_diff.max((nums[i] - nums[n - 1]).abs());
            }
        }

        max_value + max_diff
    }
}