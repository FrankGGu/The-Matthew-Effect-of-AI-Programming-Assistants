struct Solution;

impl Solution {
    pub fn first_missing_positive(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();

        let mut i = 0;
        while i < n {
            let val = nums[i];
            // Conditions for swapping:
            // 1. The value `val` must be positive.
            // 2. The value `val` must be within the valid range [1, n] for an index.
            // 3. The value `val` is not already in its correct position (i.e., nums[val-1] is not `val`).
            //    This prevents infinite loops if `nums[i]` is already `i+1` or if `nums[val-1]` is already `val`.
            if val > 0 && val as usize <= n && nums[val as usize - 1] != val {
                // Calculate the target index for `val`.
                let target_idx = val as usize - 1;
                // Swap `nums[i]` with `nums[target_idx]`.
                nums.swap(i, target_idx);
                // After a swap, the new `nums[i]` might need to be processed again,
                // so we do not increment `i`. The current `i` will be re-evaluated.
            } else {
                // If no swap occurred (because `val` is out of range, negative, or already in place),
                // move to the next element.
                i += 1;
            }
        }

        // After the first pass, iterate through the array.
        // The first index `i` where `nums[i]` is not `i + 1` indicates that `i + 1` is the first missing positive.
        for i in 0..n {
            if nums[i] != (i + 1) as i32 {
                return (i + 1) as i32;
            }
        }

        // If all numbers from 1 to n are present in their correct positions,
        // then the first missing positive is `n + 1`.
        (n + 1) as i32
    }
}