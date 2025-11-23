impl Solution {
    pub fn color_adjacent(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut nums: Vec<i32> = vec![0; n];
        let mut current_same_color_pairs: i32 = 0;
        let mut results: Vec<i32> = Vec::with_capacity(queries.len());

        for query in queries {
            let idx = query[0] as usize;
            let new_color = query[1];
            let old_color_at_idx = nums[idx];

            // If the color at `idx` is changing, we need to adjust the count
            // based on its neighbors.

            // Check the left neighbor (idx - 1)
            if idx > 0 {
                let left_neighbor_color = nums[idx - 1];

                // If the pair (idx-1, idx) was contributing before the change
                // (i.e., nums[idx-1] == old_color_at_idx and both are non-zero)
                if left_neighbor_color == old_color_at_idx && left_neighbor_color != 0 {
                    current_same_color_pairs -= 1;
                }
                // If the pair (idx-1, idx) will contribute after the change
                // (i.e., nums[idx-1] == new_color and both are non-zero)
                if left_neighbor_color == new_color && left_neighbor_color != 0 {
                    current_same_color_pairs += 1;
                }
            }

            // Check the right neighbor (idx + 1)
            if idx < n - 1 {
                let right_neighbor_color = nums[idx + 1];

                // If the pair (idx, idx+1) was contributing before the change
                // (i.e., old_color_at_idx == nums[idx+1] and both are non-zero)
                if old_color_at_idx == right_neighbor_color && old_color_at_idx != 0 {
                    current_same_color_pairs -= 1;
                }
                // If the pair (idx, idx+1) will contribute after the change
                // (i.e., new_color == nums[idx+1] and both are non-zero)
                if new_color == right_neighbor_color && new_color != 0 {
                    current_same_color_pairs += 1;
                }
            }

            // Update the color at the current index
            nums[idx] = new_color;

            // Store the current count of same-colored adjacent pairs
            results.push(current_same_color_pairs);
        }

        results
    }
}