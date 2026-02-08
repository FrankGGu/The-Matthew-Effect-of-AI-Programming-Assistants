impl Solution {
    pub fn sum_of_beauty(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 2 {
            return 0;
        }

        // max_left_prefix[i] stores the maximum value in nums[0...i]
        let mut max_left_prefix = vec![0; n];
        max_left_prefix[0] = nums[0];
        for i in 1..n {
            max_left_prefix[i] = max_left_prefix[i - 1].max(nums[i]);
        }

        // min_right_suffix[i] stores the minimum value in nums[i...n-1]
        let mut min_right_suffix = vec![0; n];
        min_right_suffix[n - 1] = nums[n - 1];
        for i in (0..n - 1).rev() {
            min_right_suffix[i] = min_right_suffix[i + 1].min(nums[i]);
        }

        let mut total_beauty = 0;

        // Iterate for i from 1 to n-2 (inclusive)
        for i in 1..n - 1 {
            // Condition 2: nums[i] is strictly greater than all elements to its left
            // and strictly smaller than all elements to its right.
            // This means nums[i] > max(nums[0...i-1]) AND nums[i] < min(nums[i+1...n-1])
            if nums[i] > max_left_prefix[i - 1] && nums[i] < min_right_suffix[i + 1] {
                total_beauty += 2;
            }
            // Condition 1: nums[i] is strictly greater than nums[i-1]
            // and strictly smaller than nums[i+1].
            else if nums[i - 1] < nums[i] && nums[i] < nums[i + 1] {
                total_beauty += 1;
            }
        }

        total_beauty
    }
}