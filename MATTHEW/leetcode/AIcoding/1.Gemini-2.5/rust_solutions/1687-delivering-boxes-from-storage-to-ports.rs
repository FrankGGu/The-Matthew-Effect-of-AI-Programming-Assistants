use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn delivering_boxes_from_storage_to_ports(
        boxes: Vec<Vec<i32>>,
        ports: i32, // This parameter is not used in the solution logic.
        max_boxes: i32,
        max_weight: i32,
    ) -> i32 {
        let n = boxes.len();
        let mut dp = vec![0; n + 1];

        // prefix_port_change_sum[k] stores the number of port changes for boxes[0...k-1].
        // Specifically, it is the sum of (1 if boxes[x-1][0] != boxes[x-2][0] else 0) for x from 2 to k.
        // prefix_port_change_sum[0] = 0 (no boxes)
        // prefix_port_change_sum[1] = 0 (only one box, no change relative to a previous box)
        // prefix_port_change_sum[k] = prefix_port_change_sum[k-1] + (1 if boxes[k-1][0] != boxes[k-2][0] else 0) for k >= 2
        // This array is of size N+1 to store values up to prefix_port_change_sum[N].
        let mut prefix_port_change_sum = vec![0; n + 1];
        for k in 2..=n {
            if boxes[k - 1][0] != boxes[k - 2][0] {
                prefix_port_change_sum[k] = prefix_port_change_sum[k - 1] + 1;
            } else {
                prefix_port_change_sum[k] = prefix_port_change_sum[k - 1];
            }
        }

        // Deque stores indices `j` which represent the start of a previous segment.
        // We want to find `min(dp[j] - prefix_port_change_sum[j+1])` over valid `j`.
        let mut q: VecDeque<usize> = VecDeque::new();
        // Initialize with j=0. dp[0] = 0. prefix_port_change_sum[0+1] = prefix_port_change_sum[1] = 0.
        // So, dp[0] - prefix_port_change_sum[1] = 0.
        q.push_back(0); 

        let mut current_weight_sum: i64 = 0; // Use i64 for sum of weights as it can exceed i32 max
        let mut left_ptr = 0; // This is the 'j' that marks the start of the current valid window for weight and max_boxes

        for i in 1..=n {
            // Add current box's weight (boxes[i-1] is the current box)
            current_weight_sum += boxes[i - 1][1] as i64;

            // Adjust `left_ptr` to satisfy `max_weight` and `max_boxes` constraints.
            // The segment for the last trip is `boxes[j..i-1]`.
            // Constraint 1: `i - j <= max_boxes` => `j >= i - max_boxes`.
            // Constraint 2: `sum(weights[j..i-1]) <= max_weight`.
            while current_weight_sum > max_weight as i64 || (i - left_ptr) as i32 > max_boxes {
                current_weight_sum -= boxes[left_ptr][1] as i64;
                left_ptr += 1;
            }

            // Remove invalid `j`'s from the front of the deque.
            // A `j` is invalid if `j < left_ptr`.
            while !q.is_empty() && *q.front().unwrap() < left_ptr {
                q.pop_front();
            }

            // Calculate `dp[i]` using the optimal `j` from the front of the deque.
            // The recurrence relation is:
            // dp[i] = min(dp[j] + 1 + (prefix_port_change_sum[i] - prefix_port_change_sum[j+1]))
            // This can be rewritten as:
            // dp[i] = 1 + prefix_port_change_sum[i] + min(dp[j] - prefix_port_change_sum[j+1])
            let j_star = *q.front().unwrap();
            dp[i] = dp[j_star] + 1 + (prefix_port_change_sum[i] - prefix_port_change_sum[j_star + 1]);

            // Add current index `i` to the deque for future calculations.
            // We only add `i` if it's not the last element (`i < n`) because `dp[N]` is the final answer
            // and we don't need to calculate `dp[N+1]` or beyond.
            // Also, `prefix_port_change_sum[i+1]` would be out of bounds if `i=N`.
            if i < n {
                let current_val_to_compare = dp[i] - prefix_port_change_sum[i + 1];
                while !q.is_empty()
                    && (dp[*q.back().unwrap()] - prefix_port_change_sum[*q.back().unwrap() + 1])
                        >= current_val_to_compare
                {
                    q.pop_back();
                }
                q.push_back(i);
            }
        }

        dp[n]
    }
}