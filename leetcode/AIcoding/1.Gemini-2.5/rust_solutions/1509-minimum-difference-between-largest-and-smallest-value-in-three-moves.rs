impl Solution {
    pub fn min_difference(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();

        if n <= 4 {
            return 0;
        }

        nums.sort();

        let mut min_diff = std::i32::MAX;

        // Option 1: Change the 3 largest elements
        // The remaining elements are nums[0]...nums[n-4]
        min_diff = min_diff.min(nums[n - 4] - nums[0]);

        // Option 2: Change the 2 largest and 1 smallest element
        // The remaining elements are nums[1]...nums[n-3]
        min_diff = min_diff.min(nums[n - 3] - nums[1]);

        // Option 3: Change the 1 largest and 2 smallest elements
        // The remaining elements are nums[2]...nums[n-2]
        min_diff = min_diff.min(nums[n - 2] - nums[2]);

        // Option 4: Change the 3 smallest elements
        // The remaining elements are nums[3]...nums[n-1]
        min_diff = min_diff.min(nums[n - 1] - nums[3]);

        min_diff
    }
}