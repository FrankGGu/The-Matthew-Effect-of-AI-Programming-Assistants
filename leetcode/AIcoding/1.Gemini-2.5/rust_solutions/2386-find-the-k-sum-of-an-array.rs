use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn k_sum(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut total_sum_neg: i64 = 0;
        let mut abs_nums: Vec<i64> = Vec::with_capacity(n);

        for &num in nums.iter() {
            if num < 0 {
                total_sum_neg += num as i64;
                abs_nums.push(-num as i64); // Add absolute value of negative numbers
            } else {
                abs_nums.push(num as i64); // Add positive numbers as is
            }
        }

        abs_nums.sort_unstable(); // Sort the absolute values in ascending order

        // Min-priority queue to store (current_sum, last_added_index)
        // Using Reverse to simulate min-heap with BinaryHeap (which is a max-heap)
        // `last_added_index` is `isize` to allow -1 for the empty set.
        let mut pq: BinaryHeap<Reverse<(i64, isize)>> = BinaryHeap::new();

        // `smallest_abs_sums` will store the k smallest sums of subsequences from `abs_nums`.
        let mut smallest_abs_sums: Vec<i64> = Vec::with_capacity(k as usize);

        // Initial state: (0, -1) representing the empty subsequence (sum 0),
        // where -1 indicates no element has been added yet.
        pq.push(Reverse((0i64, -1isize)));

        // We need to extract k sums.
        while smallest_abs_sums.len() < k as usize && !pq.is_empty() {
            let Reverse((s, i)) = pq.pop().unwrap();

            smallest_abs_sums.push(s);

            // Option 1: Add the next element (abs_nums[i+1]) to the current sum.
            // This forms a new sum by extending the current subsequence.
            // This is valid if there's a next element available.
            if (i + 1) < n as isize {
                pq.push(Reverse((s + abs_nums[(i + 1) as usize], i + 1)));
            }

            // Option 2: Replace the last added element (abs_nums[i]) with the next element (abs_nums[i+1]).
            // This forms a new sum by modifying the current subsequence.
            // This is only valid if an element was actually added (i >= 0)
            // and there's a next element to replace with.
            if i >= 0 && (i + 1) < n as isize {
                pq.push(Reverse((s - abs_nums[i as usize] + abs_nums[(i + 1) as usize], i + 1)));
            }
        }

        // The k-th smallest sum from `abs_nums` is `smallest_abs_sums[k-1]`.
        // The final answer is `total_sum_neg + smallest_abs_sums[k-1]`.
        total_sum_neg + smallest_abs_sums[k as usize - 1]
    }
}