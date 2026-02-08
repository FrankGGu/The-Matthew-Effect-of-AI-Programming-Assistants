impl Solution {
    pub fn largest_sum_after_k_negations(mut nums: Vec<i32>, mut k: i32) -> i32 {
        // Sort the array to bring the smallest (most negative) numbers to the front.
        nums.sort_unstable();

        // Iterate through the sorted array and negate negative numbers as long as k > 0.
        // This ensures we prioritize flipping the most negative numbers to positive.
        for i in 0..nums.len() {
            if nums[i] < 0 && k > 0 {
                nums[i] = -nums[i];
                k -= 1;
            } else if nums[i] >= 0 {
                // Once we encounter a non-negative number, any further numbers will also be non-negative
                // because the array is sorted. We can break early from this loop.
                // If k is still positive, we will handle it in the next step.
                break; 
            }
        }

        // If k is still odd after negating all possible negative numbers,
        // we must perform one more negation. To minimize the sum reduction,
        // we negate the number with the smallest absolute value in the current array.
        // If k is even, we don't need to do anything further as flipping the same number twice
        // effectively does nothing.
        if k % 2 == 1 {
            // Find the minimum element in the current array (by absolute value).
            // The array is no longer guaranteed to be sorted by value after negations,
            // so we must iterate to find the minimum absolute value.
            let mut min_abs_val = i32::MAX;
            let mut min_idx = 0;
            for i in 0..nums.len() {
                if nums[i].abs() < min_abs_val {
                    min_abs_val = nums[i].abs();
                    min_idx = i;
                }
            }
            // Negate the number with the smallest absolute value.
            nums[min_idx] = -nums[min_idx];
        }

        // Calculate the sum of the modified array.
        nums.iter().sum()
    }
}