impl Solution {
    pub fn count_matching_subarrays(nums: Vec<i32>, pattern: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = pattern.len();

        // If the pattern is longer than or equal to the number of possible comparisons,
        // or if the length of nums is not sufficient to form a subarray of length m+1,
        // no match is possible.
        // The problem constraints state pattern.length < nums.length, so n > m always.
        // This means nums.len() - 1 (length of comparison_array) will always be at least m.
        // So `n - 1 >= m` is guaranteed.
        // However, if m is 0, this logic would need adjustment, but m >= 1 per constraints.

        let mut comparison_array: Vec<i32> = Vec::with_capacity(n - 1);
        for i in 0..n - 1 {
            if nums[i] < nums[i + 1] {
                comparison_array.push(1);
            } else if nums[i] == nums[i + 1] {
                comparison_array.push(0);
            } else { // nums[i] > nums[i+1]
                comparison_array.push(-1);
            }
        }

        let mut count = 0;
        // Iterate through all possible windows of length `m` in `comparison_array`.
        // Each window corresponds to a subarray of `nums` of length `m + 1`.
        for window in comparison_array.windows(m) {
            // Check if the current window matches the pattern.
            // `zip` combines elements from both iterators, `all` checks if all pairs satisfy the condition.
            if window.iter().zip(pattern.iter()).all(|(&a, &b)| a == b) {
                count += 1;
            }
        }

        count
    }
}