impl Solution {
    pub fn moves_to_make_zigzag(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        // Calculate cost for pattern 1: nums[0] > nums[1] < nums[2] > ... (even indices are peaks)
        let cost1 = Self::calculate_cost_for_pattern(&nums, true);

        // Calculate cost for pattern 2: nums[0] < nums[1] > nums[2] < ... (odd indices are peaks)
        let cost2 = Self::calculate_cost_for_pattern(&nums, false);

        std::cmp::min(cost1, cost2)
    }

    fn calculate_cost_for_pattern(original_nums: &[i32], start_idx_is_peak: bool) -> i32 {
        let n = original_nums.len();
        let mut temp_nums = original_nums.to_vec(); // Copy to modify
        let mut cost = 0;

        for i in 0..n {
            let current_val = temp_nums[i];
            // Determine if the current index `i` should be a peak or a valley for this pattern
            let is_current_idx_target_peak = (i % 2 == 0 && start_idx_is_peak) || (i % 2 == 1 && !start_idx_is_peak);

            if is_current_idx_target_peak { // This index `i` should be a peak
                // Condition: temp_nums[i] > temp_nums[i-1] and temp_nums[i] > temp_nums[i+1]
                // We can only decrease elements. If neighbors are too large, decrease them.

                let mut moves_for_current_i = 0;
                let target_neighbor_val = current_val - 1; // Neighbors must be strictly less than current_val

                if i > 0 {
                    if temp_nums[i-1] >= current_val { // If left neighbor is not strictly less
                        moves_for_current_i += temp_nums[i-1] - target_neighbor_val;
                        temp_nums[i-1] = target_neighbor_val; // Apply the decrease to the neighbor
                    }
                }
                if i < n - 1 {
                    if temp_nums[i+1] >= current_val { // If right neighbor is not strictly less
                        moves_for_current_i += temp_nums[i+1] - target_neighbor_val;
                        temp_nums[i+1] = target_neighbor_val; // Apply the decrease to the neighbor
                    }
                }
                cost += moves_for_current_i;
            } else { // This index `i` should be a valley
                // Condition: temp_nums[i] < temp_nums[i-1] and temp_nums[i] < temp_nums[i+1]
                // We can only decrease elements. To satisfy this, if temp_nums[i] is too large, decrease it.

                // Sentinels: For a valley, neighbors must be larger. Use i32::MAX for non-existent neighbors.
                let left_val = if i > 0 { temp_nums[i-1] } else { i32::MAX };
                let right_val = if i < n - 1 { temp_nums[i+1] } else { i32::MAX };

                let min_neighbor = std::cmp::min(left_val, right_val);
                if current_val >= min_neighbor { // If current_val is not strictly less than its neighbors
                    cost += current_val - (min_neighbor - 1); // Decrease current_val
                    temp_nums[i] = min_neighbor - 1; // Apply the decrease to current_val
                }
            }
        }
        cost
    }
}