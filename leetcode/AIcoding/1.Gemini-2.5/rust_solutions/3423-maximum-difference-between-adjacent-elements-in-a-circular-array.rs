impl Solution {
    pub fn max_absolute_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        let mut max_diff = 0;

        for i in 0..n - 1 {
            let diff = (nums[i + 1] - nums[i]).abs();
            if diff > max_diff {
                max_diff = diff;
            }
        }

        let circular_diff = (nums[0] - nums[n - 1]).abs();
        if circular_diff > max_diff {
            max_diff = circular_diff;
        }

        max_diff
    }
}