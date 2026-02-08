impl Solution {
    pub fn min_operations(nums: Vec<i32>, target: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut operations: i64 = 0;
        let mut prev_diff: i32 = 0; // Represents the conceptual difference at index -1, which is 0

        for i in 0..n {
            let current_diff = nums[i] - target[i];

            // If the current difference is greater than the previous difference,
            // we need to perform 'increase' operations starting from this index.
            // The number of such operations is the difference between current_diff and prev_diff.
            if current_diff > prev_diff {
                operations += (current_diff - prev_diff) as i64;
            } 
            // If the current difference is less than the previous difference,
            // we need to perform 'decrease' operations starting from this index.
            // The number of such operations is the difference between prev_diff and current_diff.
            else if current_diff < prev_diff {
                operations += (prev_diff - current_diff) as i64;
            }

            // Update prev_diff for the next iteration
            prev_diff = current_diff;
        }

        operations
    }
}