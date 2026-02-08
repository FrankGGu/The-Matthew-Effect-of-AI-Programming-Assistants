use std::cmp::{max, min};

impl Solution {
    pub fn maximize_the_topmost_element(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k_usize = k as usize;

        // If k is 0, no moves are made, so the topmost element is nums[0].
        if k_usize == 0 {
            return nums[0];
        }

        // Special case: If there's only one element in the array.
        if n == 1 {
            // If k is odd, we remove the only element. The stack becomes empty.
            // We have k-1 (even) moves left. We can add the element back, then remove it,
            // and so on. We will always end with an empty stack.
            // Example: nums=[1], k=1 -> remove 1, stack empty.
            // Example: nums=[1], k=3 -> remove 1, add 1, remove 1, stack empty.
            if k_usize % 2 == 1 {
                return -1;
            } else {
                // If k is even, we remove the element, then add it back.
                // We have k-2 (even) moves left, which can be used to repeatedly remove and add the element.
                // We will always end with nums[0] at the top.
                // Example: nums=[1], k=2 -> remove 1, add 1, stack is [1].
                // Example: nums=[1], k=4 -> remove 1, add 1, remove 1, add 1, stack is [1].
                return nums[0];
            }
        }

        // General case: n > 1 and k > 0.
        let mut max_val = 0; // Constraints: 0 <= nums[i] <= 10^9, so 0 is a safe initial minimum.

        // Possibility 1: An element `nums[i]` (where `i < k`) is at the top
        // after being removed and then re-added.
        // To make `nums[i]` the topmost element:
        // 1. We must remove `nums[0]` through `nums[i]`. This takes `i + 1` moves.
        //    At this point, `nums[0]`...`nums[i]` are in the removed elements pool.
        // 2. We then add `nums[i]` back to the top. This takes `1` move.
        // Total moves used so far: `(i + 1) + 1 = i + 2`.
        // We have `k_usize - (i + 2)` moves remaining.
        // For `nums[i]` to remain at the top, these remaining moves must be used up
        // by repeatedly removing `nums[i]` and adding `nums[i]` back.
        // This means `k_usize - (i + 2)` must be a non-negative even number.
        // This implies `i + 2 <= k_usize` (i.e., `i <= k_usize - 2`).
        // Also, `i` must be a valid index in `nums`, so `i < n`.
        // Therefore, `i` can range from `0` up to `min(n - 1, k_usize - 2)`.
        // We want the maximum value among these possible `nums[i]`.
        // The loop `0..min(n, k_usize - 1)` effectively covers `i` from `0` to `min(n-1, k_usize-2)`.
        for i in 0..min(n, k_usize - 1) {
            max_val = max_val.max(nums[i]);
        }

        // Possibility 2: The element at index `k_usize` becomes the top.
        // This happens if we simply perform `k_usize` removal operations.
        // This is only possible if `k_usize` is a valid index, i.e., `k_usize < n`.
        if k_usize < n {
            max_val = max_val.max(nums[k_usize]);
        }

        max_val
    }
}