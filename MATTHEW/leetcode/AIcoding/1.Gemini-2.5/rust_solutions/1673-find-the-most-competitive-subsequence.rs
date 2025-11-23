impl Solution {
    pub fn most_competitive(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k_usize = k as usize;

        let mut result: Vec<i32> = Vec::with_capacity(k_usize);

        for i in 0..n {
            let num = nums[i];

            while let Some(&last_val) = result.last() {
                // Condition to pop:
                // 1. The stack is not empty.
                // 2. The current number `num` is smaller than the last element in `result`.
                // 3. We still have enough elements remaining (including `num` itself and future elements)
                //    to form a subsequence of length `k` even after popping.
                //    `result.len()` is current size. If we pop, it becomes `result.len() - 1`.
                //    The number of elements remaining in `nums` *after* the current `i` is `n - (i + 1)`.
                //    If we pop, then add `num`, then add `n - (i + 1)` future elements,
                //    the total available slots would be `(result.len() - 1) + 1 + (n - (i + 1))`.
                //    This simplifies to `result.len() + n - i - 1`.
                //    This total must be greater than or equal to `k_usize`.
                if last_val > num && (result.len() + (n - i - 1)) >= k_usize {
                    result.pop();
                } else {
                    break;
                }
            }

            // Only push if the result subsequence has not yet reached the desired length `k`.
            // If `result.len() == k_usize`, we don't push, as we already have `k` elements
            // and the current `num` was not small enough to replace the last element (or we would have popped).
            if result.len() < k_usize {
                result.push(num);
            }
        }

        result
    }
}