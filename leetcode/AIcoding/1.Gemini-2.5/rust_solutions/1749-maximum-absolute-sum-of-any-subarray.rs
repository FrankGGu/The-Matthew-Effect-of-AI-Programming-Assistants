impl Solution {
    pub fn max_absolute_sum(nums: Vec<i32>) -> i32 {
        let mut max_so_far = nums[0];
        let mut current_max = nums[0];
        let mut min_so_far = nums[0];
        let mut current_min = nums[0];

        for i in 1..nums.len() {
            let num = nums[i];

            // Kadane's algorithm for maximum subarray sum
            current_max = num.max(current_max + num);
            max_so_far = max_so_far.max(current_max);

            // Kadane's algorithm for minimum subarray sum
            current_min = num.min(current_min + num);
            min_so_far = min_so_far.min(current_min);
        }

        max_so_far.abs().max(min_so_far.abs())
    }
}