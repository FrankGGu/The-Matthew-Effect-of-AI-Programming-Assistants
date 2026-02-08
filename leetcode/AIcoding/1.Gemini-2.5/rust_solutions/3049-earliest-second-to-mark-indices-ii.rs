use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn earliest_second_to_mark_indices(nums: Vec<i32>, mark_indices: Vec<i32>) -> i32 {
        let m = nums.len(); // Number of indices to mark
        let n = mark_indices.len(); // Number of available mark events

        // If no indices to mark, 0 seconds needed. Problem constraints state m >= 1.
        if m == 0 {
            return 0;
        }

        // Binary search for the minimum total time 't'
        let mut low = 1;
        // Upper bound: max seconds (n) + max sum of nums (m * max_num_val).
        // Max num_val is 10^9. Max m is 2*10^5. Max n is 2*10^5.
        // So, n + m * 10^9 approx 2*10^5 + 2*10^5 * 10^9 = 2*10^5 * (1 + 10^9) approx 2*10^14.
        // This fits in i64.
        let mut high = n as i64 + m as i64 * 1_000_000_000;
        let mut ans = -1;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, &nums, &mark_indices, m) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        ans as i32
    }

    // Checks if it's possible to mark all 'm' indices such that
    // max_j_marked + sum_of_nums_for_marked_indices <= max_total_time.
    fn check(max_total_time: i64, nums: &[i32], mark_indices: &[i32], m: usize) -> bool {
        // last_valid_mark_time[i] stores the latest second (1-indexed) <= n
        // where index 'i' (0-indexed) can be marked, considering nums[i] constraints.
        // Initialized to 0, meaning not available or not valid by any time.
        let mut last_valid_mark_time: Vec<i64> = vec![0; m];

        // Populate last_valid_mark_time
        // Iterate through all available mark events (up to 'n' seconds, mark_indices.len())
        for k in 0..mark_indices.len() {
            let current_second = (k + 1) as i64;
            let idx = (mark_indices[k] - 1) as usize; // Convert to 0-indexed index
            let num_val = nums[idx] as i64;

            // Check if this marking event is valid for index 'idx' at 'current_second'
            if num_val == 0 || current_second >= num_val {
                last_valid_mark_time[idx] = current_second; // Keep the latest valid time
            }
        }

        // Priority queue (max-heap) to store nums[idx] values of chosen indices.
        // We want to keep the sum of nums[idx] as small as possible.
        // When choosing, if we have 'm' indices already, we replace the largest current nums[idx]
        // with a smaller one if available.
        let mut pq: BinaryHeap<i32> = BinaryHeap::new();
        let mut current_sum_of_nums: i64 = 0;

        // Iterate backwards from the maximum possible marking second (n) down to 1.
        // This greedy strategy ensures that if an index can be marked at multiple times,
        // we consider its latest possible valid time first.
        for s in (1..=(mark_indices.len() as i64)).rev() {
            // Find the index that has its latest valid marking opportunity at second 's'.
            let mut idx_at_s: Option<usize> = None;
            for idx in 0..m {
                if last_valid_mark_time[idx] == s {
                    idx_at_s = Some(idx);
                    break;
                }
            }

            if let Some(idx) = idx_at_s {
                let num_val = nums[idx];
                // If we haven't chosen 'm' indices yet, add this one.
                if pq.len() < m {
                    pq.push(num_val);
                    current_sum_of_nums += num_val as i64;
                } else if num_val < *pq.peek().unwrap() {
                    // If we have 'm' indices, but this one is "cheaper" (smaller nums[idx]),
                    // swap it with the most expensive one currently in the priority queue.
                    current_sum_of_nums -= pq.pop().unwrap() as i64;
                    pq.push(num_val);
                    current_sum_of_nums += num_val as i64;
                }
            }

            // At any second 's' (which could be the maximum marking time for some set of 'm' indices),
            // if we have successfully chosen 'm' indices:
            if pq.len() == m {
                // Check if the total time (max_j_marked + sum_of_nums) is within max_total_time.
                // 's' represents the current maximum marking time if these 'm' indices are marked.
                if s + current_sum_of_nums <= max_total_time {
                    return true; // It's possible to achieve max_total_time
                }
            }
        }

        // If the loop finishes and we haven't returned true, it means
        // we couldn't find a valid set of 'm' indices within the total time limit.
        false
    }
}