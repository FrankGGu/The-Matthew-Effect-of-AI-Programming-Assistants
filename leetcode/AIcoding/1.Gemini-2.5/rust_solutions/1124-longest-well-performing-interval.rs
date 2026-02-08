use std::collections::HashMap;

impl Solution {
    pub fn longest_well_performing_interval(hours: Vec<i32>) -> i32 {
        let n = hours.len();
        if n == 0 {
            return 0;
        }

        // Calculate prefix sums.
        // prefix_sums[k] stores the sum of scores for hours[0...k-1].
        // A tiring day (hours > 8) contributes +1, a non-tiring day (hours <= 8) contributes -1.
        // We want to find the longest interval [i, j-1] such that sum(scores[i...j-1]) > 0.
        // This is equivalent to prefix_sums[j] - prefix_sums[i] > 0, or prefix_sums[j] > prefix_sums[i].
        let mut prefix_sums = vec![0; n + 1];
        let mut current_sum = 0;
        for i in 0..n {
            current_sum += if hours[i] > 8 { 1 } else { -1 };
            prefix_sums[i + 1] = current_sum;
        }

        // Monotonic stack to store indices `i` such that `prefix_sums[i]` is strictly decreasing.
        // This helps in efficiently finding the smallest `i` for a given `j` that satisfies `prefix_sums[j] > prefix_sums[i]`.
        let mut stack: Vec<usize> = Vec::new();
        for i in 0..=n {
            // Push index `i` onto the stack if `prefix_sums[i]` is strictly less than the prefix sum at the top of the stack.
            // This maintains a strictly decreasing sequence of prefix sums corresponding to indices in the stack.
            if stack.is_empty() || prefix_sums[i] < prefix_sums[*stack.last().unwrap()] {
                stack.push(i);
            }
        }

        let mut max_len = 0;
        // Iterate `j` from `n` down to `0`.
        // For each `j`, we want to find the smallest `i` in the stack such that `prefix_sums[j] > prefix_sums[i]`.
        // If such an `i` is found, the length of the well-performing interval is `j - i`.
        // We pop `i` from the stack because for any `j'` smaller than `j`, if `prefix_sums[j'] > prefix_sums[i]`,
        // then `j - i` would be a longer interval than `j' - i`.
        for j in (0..=n).rev() {
            while let Some(&i) = stack.last() {
                if prefix_sums[j] > prefix_sums[i] {
                    // Found an interval [i, j-1] where prefix_sums[j] > prefix_sums[i].
                    // Its length is j - i.
                    max_len = max_len.max(j - i);
                    stack.pop(); // Pop `i` as we've found the best `j` for it.
                } else {
                    // `prefix_sums[j] <= prefix_sums[i]`.
                    // Since the stack stores indices with strictly decreasing prefix sums,
                    // any earlier index `i'` (i.e., `i'` < `i`) in the stack would have `prefix_sums[i'] >= prefix_sums[i]`.
                    // Thus, `prefix_sums[j]` would also be less than or equal to `prefix_sums[i']`.
                    // So, no further `i'` in the current stack would satisfy `prefix_sums[j] > prefix_sums[i']`.
                    // We can stop checking for this `j`.
                    break;
                }
            }
        }

        max_len as i32
    }
}