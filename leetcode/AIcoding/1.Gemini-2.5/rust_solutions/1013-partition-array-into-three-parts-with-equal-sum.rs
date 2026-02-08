impl Solution {
    pub fn can_three_parts_equal_sum(a: Vec<i32>) -> bool {
        let total_sum: i32 = a.iter().sum();

        // If the total sum is not divisible by 3, it's impossible to partition
        // into three parts with equal sums.
        if total_sum % 3 != 0 {
            return false;
        }

        let target_sum = total_sum / 3;
        let mut current_sum = 0;
        let mut parts_found = 0;

        // Iterate through the array to find the partitions.
        for num in a {
            current_sum += num;

            // If current_sum equals target_sum, we've found a part.
            // We only increment parts_found if we haven't already found 3 parts.
            // This ensures we count exactly three distinct segments that sum to target_sum.
            if current_sum == target_sum && parts_found < 3 {
                parts_found += 1;
                current_sum = 0; // Reset current_sum for the next part
            }
        }

        // We need to have found exactly three parts.
        // The condition `parts_found < 3` inside the loop ensures that if there are
        // more segments that sum to `target_sum`, they are not counted as new parts
        // beyond the third one. If `parts_found` reaches 3, it means the first two
        // parts were found, and the remaining elements (which sum to `target_sum`
        // because `total_sum` is `3 * target_sum`) constitute the third part.
        // The `current_sum = 0` after finding the third part ensures that any
        // trailing elements are correctly accounted for as part of the third segment.
        parts_found == 3
    }
}