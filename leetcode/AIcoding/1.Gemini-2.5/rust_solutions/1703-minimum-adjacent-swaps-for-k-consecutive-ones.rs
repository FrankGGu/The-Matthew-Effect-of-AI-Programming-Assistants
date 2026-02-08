impl Solution {
    pub fn min_moves(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut ones_indices = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                ones_indices.push(i as i64);
            }
        }

        let n_ones = ones_indices.len();
        if n_ones < k {
            return 0; 
        }
        if k == 0 {
            return 0;
        }

        // Transform ones_indices to q_arr: q_j = ones_indices[j] - j
        // This transformation is key. If we want to move k ones from positions p_0, ..., p_{k-1}
        // to x, x+1, ..., x+k-1, the number of adjacent swaps required is
        // sum_{i=0}^{k-1} |p_i - (x+i)|.
        // This can be rewritten as sum_{i=0}^{k-1} |(p_i - i) - x|.
        // Let q_i = p_i - i. We need to minimize sum_{i=0}^{k-1} |q_i - x|.
        // This sum is minimized when x is the median of the q_i values.
        // Since ones_indices are sorted, and we subtract increasing j, q_arr will also be sorted.
        let mut q_arr: Vec<i64> = Vec::with_capacity(n_ones);
        for (j, &pos) in ones_indices.iter().enumerate() {
            q_arr.push(pos - j as i64);
        }

        // Calculate prefix sums for q_arr to efficiently compute sum of elements in a range
        // prefix_sums[x] = sum(q_arr[0]...q_arr[x-1])
        let mut prefix_sums: Vec<i64> = Vec::with_capacity(n_ones + 1);
        prefix_sums.push(0);
        for &q_val in q_arr.iter() {
            prefix_sums.push(prefix_sums.last().unwrap() + q_val);
        }

        let mut min_swaps = i64::MAX;

        // Iterate through all possible windows of k consecutive ones in the original array.
        // Each window corresponds to a sub-array of size k in q_arr: q_arr[i .. i+k-1]
        for i in 0..=(n_ones - k) {
            // The median element's index in the current window (0-indexed relative to window start)
            // For even k, we pick the left of the two middle elements as the median.
            let median_idx_in_window = k / 2;
            // The median element's global index in q_arr
            let median_global_idx = i + median_idx_in_window;
            // The value of the median element
            let median_val = q_arr[median_global_idx];

            // Calculate the number of elements to the left and right of the median in the window
            let left_len = median_global_idx - i;
            let right_len = (i + k) - (median_global_idx + 1);

            // Calculate the sum of elements to the left and right of the median in the window
            // S_left = sum(q_arr[i]...q_arr[median_global_idx-1])
            let s_left = prefix_sums[median_global_idx] - prefix_sums[i];
            // S_right = sum(q_arr[median_global_idx+1]...q_arr[i+k-1])
            let s_right = prefix_sums[i + k] - prefix_sums[median_global_idx + 1];

            // The total swaps for this window is sum(|q_j - median_val|)
            // This can be calculated as:
            // (sum of (median_val - q_j) for q_j < median_val) + (sum of (q_j - median_val) for q_j > median_val)
            // = (left_len * median_val - s_left) + (s_right - right_len * median_val)
            let current_swaps = (left_len as i64 * median_val - s_left) + (s_right - right_len as i64 * median_val);

            min_swaps = min_swaps.min(current_swaps);
        }

        min_swaps as i32
    }
}