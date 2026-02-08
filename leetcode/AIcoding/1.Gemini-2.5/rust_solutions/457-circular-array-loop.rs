impl Solution {
    pub fn circular_array_loop(nums: &mut Vec<i32>) -> bool {
        let n = nums.len();

        // Helper function to get the next index, checking for direction consistency and cycle length 1.
        // Returns Some(next_idx) if valid, None otherwise.
        fn get_next(nums: &[i32], current_idx: usize, is_positive_direction: bool) -> Option<usize> {
            let n = nums.len();
            let val = nums[current_idx];

            // If current node is marked as 0, it's invalid for any path.
            if val == 0 {
                return None;
            }

            // Check if the current element's direction matches the expected direction for the loop.
            if (val > 0) != is_positive_direction {
                return None; // Direction mismatch
            }

            // Calculate the next index.
            let mut next_idx = (current_idx as i32 + val) % n as i32;
            if next_idx < 0 {
                next_idx += n as i32; // Ensure positive index for Rust's usize
            }

            // Check for a cycle of length 1 (moving to the same index).
            if next_idx as usize == current_idx {
                return None; // Cycle of length 1 is not allowed
            }

            Some(next_idx as usize)
        }

        for i in 0..n {
            // If nums[i] is 0, this node has already been visited and marked
            // as part of an invalid path or a path that doesn't lead to a cycle.
            if nums[i] == 0 {
                continue;
            }

            let is_positive_direction = nums[i] > 0;
            let mut slow = i;
            let mut fast = i;

            loop {
                // Move slow pointer one step.
                slow = match get_next(nums, slow, is_positive_direction) {
                    Some(idx) => idx,
                    None => break, // Invalid path detected (direction mismatch, length 1 cycle, or 0-marked node)
                };

                // Move fast pointer two steps.
                fast = match get_next(nums, fast, is_positive_direction) {
                    Some(idx) => idx,
                    None => break, // Invalid path
                };
                fast = match get_next(nums, fast, is_positive_direction) {
                    Some(idx) => idx,
                    None => break, // Invalid path
                };

                // If slow and fast pointers meet, a cycle is detected.
                if slow == fast {
                    return true;
                }
            }

            // If the loop breaks, it means no valid cycle was found starting from 'i'
            // or the path was invalid. Mark all nodes in this path as 0 to avoid re-processing them.
            let mut current_to_mark = i;
            // We need to store the initial value and direction to correctly traverse and mark.
            let mut current_val = nums[current_to_mark];
            let initial_direction_positive = current_val > 0;

            // Traverse the path from 'i' and mark nodes as 0 until an invalid condition is met.
            while current_val != 0 && (current_val > 0) == initial_direction_positive {
                let next_idx_raw = (current_to_mark as i32 + current_val) % n as i32;
                let next_idx = if next_idx_raw < 0 { next_idx_raw + n as i32 } else { next_idx_raw } as usize;

                nums[current_to_mark] = 0; // Mark the current node as visited and invalid.

                // Move to the next node.
                current_to_mark = next_idx;
                current_val = nums[current_to_mark]; // Get value of the new current node.
            }
        }

        false // No circular array loop found after checking all starting points.
    }
}