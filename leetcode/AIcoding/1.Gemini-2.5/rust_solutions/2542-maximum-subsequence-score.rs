use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_score(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        let n = nums1.len();
        let k = k as usize;

        let mut pairs: Vec<(i32, i32)> = Vec::with_capacity(n);
        for i in 0..n {
            pairs.push((nums2[i], nums1[i]));
        }

        // Sort pairs by nums2 values in descending order.
        // This ensures that when we iterate, current_nums2 is a candidate for the minimum
        // nums2 value in any chosen subsequence, and all previously considered pairs
        // have nums2 values greater than or equal to current_nums2.
        pairs.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut max_score: i64 = 0;
        let mut current_sum_nums1: i64 = 0;
        // A min-priority queue to store the k largest nums1 values encountered so far.
        // We use Reverse to make BinaryHeap act as a min-heap.
        let mut min_heap: BinaryHeap<Reverse<i32>> = BinaryHeap::new();

        for i in 0..n {
            let (current_nums2, current_nums1) = pairs[i];

            current_sum_nums1 += current_nums1 as i64;
            min_heap.push(Reverse(current_nums1));

            // If the heap size exceeds k, remove the smallest nums1 value
            // to maintain only the k largest nums1 values.
            if min_heap.len() > k {
                if let Some(Reverse(val)) = min_heap.pop() {
                    current_sum_nums1 -= val as i64;
                }
            }

            // Once we have k elements in the heap, we can calculate a potential score.
            // current_sum_nums1 holds the sum of the k largest nums1 values.
            // current_nums2 is the minimum nums2 value among these k elements
            // because of the initial sorting by nums2 in descending order.
            if min_heap.len() == k {
                max_score = max_score.max(current_sum_nums1 * current_nums2 as i64);
            }
        }

        max_score
    }
}