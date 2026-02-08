impl Solution {
    pub fn max_sequence_value(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        if n < 3 {
            return 0;
        }

        let mut max_val: i64 = 0;
        let mut max_i: i64 = nums[0] as i64; // Stores max(nums[x]) for x < current_idx
        let mut max_i_minus_j: i64 = i64::MIN; // Stores max(nums[x] - nums[y]) for x < y < current_idx

        // Iterate through the array starting from the second element (index 1)
        // current_idx will act as 'j' in the first update, and 'k' in the second update.
        for current_idx in 1..n {
            let current_num = nums[current_idx] as i64;

            // If current_idx is 2 or greater, we can potentially form a sequence (i, j, k)
            // where k = current_idx.
            // max_i_minus_j at this point holds the maximum (nums[i] - nums[j]) for i < j < current_idx.
            if current_idx >= 2 {
                max_val = max_val.max(max_i_minus_j * current_num);
            }

            // Update max_i_minus_j:
            // This prepares max_i_minus_j for the next iteration where current_idx + 1 will be 'k'.
            // max_i holds max(nums[x]) for x < current_idx.
            // We consider current_num as nums[j] for the expression nums[i] - nums[j].
            max_i_minus_j = max_i_minus_j.max(max_i - current_num);

            // Update max_i:
            // This prepares max_i for the next iteration where current_idx + 1 will be 'j'.
            // current_num is now a candidate for the maximum nums[x].
            max_i = max_i.max(current_num);
        }

        max_val
    }
}