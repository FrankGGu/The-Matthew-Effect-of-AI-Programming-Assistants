use std::collections::HashMap;

impl Solution {
    pub fn number_of_subarrays_where_boundary_elements_are_maximum(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        // pg[i] stores the index of the previous element strictly greater than nums[i].
        // If no such element exists, it's -1.
        let mut pg = vec![0; n];
        let mut stack: Vec<usize> = Vec::new(); // Stores indices in increasing order of values

        for i in 0..n {
            // Pop elements from stack that are less than or equal to nums[i]
            // because they cannot be the previous strictly greater element for subsequent elements.
            while let Some(&top_idx) = stack.last() {
                if nums[top_idx] <= nums[i] {
                    stack.pop();
                } else {
                    break;
                }
            }

            // The top of the stack (if any) is the previous strictly greater element.
            pg[i] = if let Some(&top_idx) = stack.last() {
                top_idx as i32
            } else {
                -1
            };
            stack.push(i);
        }

        let mut ans: i64 = 0;
        // Stores a list of indices for each value, in increasing order.
        let mut val_indices: HashMap<i32, Vec<usize>> = HashMap::new();

        for r in 0..n {
            let current_val = nums[r];
            let prev_greater_idx = pg[r];

            // Add the current index 'r' to the list of indices for 'current_val'.
            val_indices.entry(current_val).or_default().push(r);

            // Retrieve the list of indices for 'current_val'.
            if let Some(indices) = val_indices.get(&current_val) {
                // We need to count 'l' in 'indices' such that:
                // 1. nums[l] == nums[r] (ensured by looking in val_indices[current_val])
                // 2. l <= r (ensured by how 'indices' is built and processed)
                // 3. For all k in (l, r), nums[k] <= nums[r] (ensured by prev_greater_idx)
                //    This means 'l' must be greater than 'prev_greater_idx'.

                // We are looking for 'l' such that 'prev_greater_idx < l'.
                // This is equivalent to 'l >= prev_greater_idx + 1'.
                let search_val = (prev_greater_idx + 1) as usize;

                // Find the first index in 'indices' that is >= search_val.
                // This is a lower_bound operation.
                let mut low = 0;
                let mut high = indices.len();
                let mut first_valid_idx = indices.len(); // Default to no elements found

                while low < high {
                    let mid = low + (high - low) / 2;
                    if indices[mid] >= search_val {
                        first_valid_idx = mid;
                        high = mid;
                    } else {
                        low = mid + 1;
                    }
                }

                // The number of valid 'l' indices is the count of elements from 'first_valid_idx' to the end.
                ans += (indices.len() - first_valid_idx) as i64;
            }
        }

        ans
    }
}