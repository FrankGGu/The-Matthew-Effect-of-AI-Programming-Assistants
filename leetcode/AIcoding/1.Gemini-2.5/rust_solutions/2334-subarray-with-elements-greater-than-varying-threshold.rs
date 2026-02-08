struct Solution;

impl Solution {
    pub fn valid_subarray_size(nums: Vec<i32>, threshold: i32) -> bool {
        let n = nums.len();
        if n == 0 {
            return false;
        }

        let mut nsl = vec![-1; n]; // Nearest Smaller to Left
        let mut nsr = vec![n as i32; n]; // Nearest Smaller to Right
        let mut stack: Vec<usize> = Vec::new();

        // Calculate NSL (Nearest Smaller Element to the Left)
        // For each element nums[i], find the index of the first element to its left
        // that is strictly smaller than nums[i].
        for i in 0..n {
            while let Some(&top_idx) = stack.last() {
                if nums[top_idx] >= nums[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            if let Some(&top_idx) = stack.last() {
                nsl[i] = top_idx as i32;
            }
            stack.push(i);
        }

        stack.clear();

        // Calculate NSR (Nearest Smaller Element to the Right)
        // For each element nums[i], find the index of the first element to its right
        // that is strictly smaller than nums[i].
        for i in (0..n).rev() {
            while let Some(&top_idx) = stack.last() {
                if nums[top_idx] >= nums[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            if let Some(&top_idx) = stack.last() {
                nsr[i] = top_idx as i32;
            }
            stack.push(i);
        }

        // For each element nums[i], consider it as the minimum element of a potential subarray.
        // The largest subarray for which nums[i] is the minimum extends from (nsl[i] + 1) to (nsr[i] - 1).
        // Let this subarray be [left_bound, right_bound].
        // Its length is (right_bound - left_bound + 1).
        for i in 0..n {
            let left_bound = nsl[i];
            let right_bound = nsr[i];
            let length = right_bound - left_bound - 1; // Length of the subarray where nums[i] is the minimum.

            // The problem condition is: for a subarray of length `L`, every element `x` must satisfy `x > threshold / L`.
            // This is equivalent to `min_val_in_subarray * L > threshold`.
            // Here, `nums[i]` is the minimum value for the subarray of `length`.
            // We need to check if `nums[i] * length > threshold`.
            // Use `i64` for multiplication to prevent potential overflow, as `nums[i]` and `threshold` can be large.
            if (nums[i] as i64) * (length as i64) > (threshold as i64) {
                return true;
            }
        }

        false
    }
}