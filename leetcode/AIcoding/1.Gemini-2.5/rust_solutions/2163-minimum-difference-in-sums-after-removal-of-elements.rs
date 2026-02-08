use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_difference(nums: Vec<i32>) -> i64 {
        let n = nums.len() / 3;
        let total_len = nums.len();

        // pref_min_sum[i] stores the sum of the n smallest elements from nums[0...i].
        // We use a max-heap to maintain the n smallest elements encountered so far.
        // If the heap size exceeds n, we remove the largest element from the heap.
        let mut pref_min_sum: Vec<i64> = vec![0; total_len];
        let mut pq_left = BinaryHeap::new(); // Max-heap for i32
        let mut current_sum_left: i64 = 0;

        for i in 0..total_len {
            pq_left.push(nums[i]);
            current_sum_left += nums[i] as i64;

            if pq_left.len() > n {
                current_sum_left -= pq_left.pop().unwrap() as i64;
            }

            // When the heap contains exactly n elements, its sum is the sum of the n smallest
            // elements from nums[0...i].
            if pq_left.len() == n {
                pref_min_sum[i] = current_sum_left;
            }
        }

        // suff_max_sum[i] stores the sum of the n largest elements from nums[i...3n-1].
        // We use a min-heap to maintain the n largest elements encountered so far.
        // If the heap size exceeds n, we remove the smallest element from the heap.
        let mut suff_max_sum: Vec<i64> = vec![0; total_len];
        let mut pq_right = BinaryHeap::new(); // Min-heap for i32 (using Reverse)
        let mut current_sum_right: i64 = 0;

        for i in (0..total_len).rev() {
            pq_right.push(Reverse(nums[i]));
            current_sum_right += nums[i] as i64;

            if pq_right.len() > n {
                current_sum_right -= pq_right.pop().unwrap().0 as i64;
            }

            // When the heap contains exactly n elements, its sum is the sum of the n largest
            // elements from nums[i...3n-1].
            if pq_right.len() == n {
                suff_max_sum[i] = current_sum_right;
            }
        }

        let mut min_diff: i64 = i64::MAX;

        // Iterate through possible split points 'k'.
        // 'k' represents the last index in the original `nums` array from which the first `n`
        // elements (for the left sum) can be chosen.
        // This means the first `n` elements are chosen from `nums[0...k]`,
        // and the last `n` elements are chosen from `nums[k+1...3n-1]`.
        //
        // For `pref_min_sum[k]` to be valid, `k` must be at least `n-1`.
        // For `suff_max_sum[k+1]` to be valid, `k+1` must be at most `3n - n = 2n`.
        // So, `k` ranges from `n-1` to `2n-1`.
        for k in (n - 1)..(2 * n) {
            let diff = pref_min_sum[k] - suff_max_sum[k + 1];
            min_diff = min_diff.min(diff);
        }

        min_diff
    }
}