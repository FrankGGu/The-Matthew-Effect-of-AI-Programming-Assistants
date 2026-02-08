impl Solution {
    pub fn maximum_sum_of_heights(max_heights: Vec<i32>) -> i64 {
        let n = max_heights.len();
        let mut left_sums = vec![0i64; n];
        let mut right_sums = vec![0i64; n];

        let mut stack: Vec<(usize, i32)> = Vec::new(); // Stores (index, height)
        let mut current_sum = 0i64;

        // Calculate left_sums: sum of heights for towers 0 to i, with i as the peak
        for i in 0..n {
            let h_i = max_heights[i];
            let mut effective_start_idx = i; // This tracks the leftmost index for the current segment determined by h_i

            // Pop elements from stack that are taller than or equal to h_i
            while let Some(&(idx_on_stack, h_on_stack)) = stack.last() {
                if h_on_stack >= h_i {
                    // Remove the contribution of the popped segment from current_sum
                    // The segment was from idx_on_stack to effective_start_idx - 1, all at height h_on_stack
                    current_sum -= (h_on_stack as i64) * ((effective_start_idx - idx_on_stack) as i64);
                    effective_start_idx = idx_on_stack; // The new effective start index is the start of the popped segment
                    stack.pop();
                } else {
                    break;
                }
            }

            // Add the contribution of the new segment determined by h_i
            // This segment is from effective_start_idx to i, all at height h_i
            current_sum += (h_i as i64) * ((i - effective_start_idx + 1) as i64);
            stack.push((effective_start_idx, h_i)); // Push h_i with its effective starting index
            left_sums[i] = current_sum;
        }

        stack.clear();
        current_sum = 0;

        // Calculate right_sums: sum of heights for towers i to n-1, with i as the peak
        // This is similar to left_sums, but iterated from right to left
        for i in (0..n).rev() {
            let h_i = max_heights[i];
            let mut effective_end_idx = i; // This tracks the rightmost index for the current segment determined by h_i

            // Pop elements from stack that are taller than or equal to h_i
            while let Some(&(idx_on_stack, h_on_stack)) = stack.last() {
                if h_on_stack >= h_i {
                    // Remove the contribution of the popped segment from current_sum
                    // The segment was from effective_end_idx + 1 to idx_on_stack, all at height h_on_stack
                    current_sum -= (h_on_stack as i64) * ((idx_on_stack - effective_end_idx) as i64);
                    effective_end_idx = idx_on_stack; // The new effective end index is the end of the popped segment
                    stack.pop();
                } else {
                    break;
                }
            }

            // Add the contribution of the new segment determined by h_i
            // This segment is from i to effective_end_idx, all at height h_i
            current_sum += (h_i as i64) * ((effective_end_idx - i + 1) as i64);
            stack.push((effective_end_idx, h_i)); // Push h_i with its effective ending index
            right_sums[i] = current_sum;
        }

        let mut max_total_height = 0i64;
        for i in 0..n {
            // For each tower i as the peak, the total height is left_sums[i] + right_sums[i] - max_heights[i]
            // We subtract max_heights[i] because it's counted in both left_sums[i] and right_sums[i]
            max_total_height = max_total_height.max(left_sums[i] + right_sums[i] - max_heights[i] as i64);
        }

        max_total_height
    }
}