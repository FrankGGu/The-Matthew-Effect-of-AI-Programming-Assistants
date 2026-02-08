use std::collections::VecDeque;

impl Solution {
    pub fn collect_chocolates(cost: Vec<i32>, x: i32) -> i64 {
        let n = cost.len();
        let x_i64 = x as i64;

        // P[p] = cost[p % n] + p * x
        // This array stores the effective cost of a chocolate if it's collected after `p` rotations,
        // where `cost[p % n]` is its base cost and `p * x` is the rotation cost.
        // We need this for `p` up to `2n - 1` to cover all sliding windows of size `n`.
        // The values can be large (up to 2 * 10^14), so `i64` is used.
        let mut p_values: Vec<i64> = Vec::with_capacity(2 * n);
        for p in 0..(2 * n) {
            let current_cost = cost[p % n] as i64;
            let rotation_cost = (p as i64) * x_i64;
            p_values.push(current_cost + rotation_cost);
        }

        // `total_min_cost` will store the sum of minimum costs for each initial chocolate.
        // This sum can exceed `i64::MAX` in worst-case, so `i128` is used for safety.
        // The final result is cast to `i64` as per the function signature.
        let mut total_min_cost: i128 = 0;

        // Deque for sliding window minimum
        let mut dq: VecDeque<usize> = VecDeque::new();

        // Process the first window [0, n-1] for the initial chocolate at index 0.
        // This calculates `min_{k=0}^{n-1} (P[k])`.
        for p in 0..n {
            while let Some(&back_idx) = dq.back() {
                if p_values[back_idx] >= p_values[p] {
                    dq.pop_back();
                } else {
                    break;
                }
            }
            dq.push_back(p);
        }
        // The minimum for the window [0, n-1] is `P[*dq.front().unwrap()]`.
        // For chocolate `i`, the minimum cost is `(min_{p=i}^{i+n-1} P[p]) - i * x`.
        // For `i=0`, it's `P[*dq.front().unwrap()] - 0 * x`.
        total_min_cost += (p_values[*dq.front().unwrap()] - 0 * x_i64) as i128;

        // Slide the window for subsequent initial chocolates (i = 1 to n-1).
        // For each `i`, we need to find `min_{p=i}^{i+n-1} P[p]`.
        for i in 1..n {
            // Remove elements from the front of the deque that are no longer in the current window.
            // The window is `[i, i + n - 1]`.
            if let Some(&front_idx) = dq.front() {
                if front_idx < i {
                    dq.pop_front();
                }
            }

            // Add the new element `P[i + n - 1]` to the back of the deque,
            // maintaining the increasing order of values (from front to back).
            let new_idx = i + n - 1;
            while let Some(&back_idx) = dq.back() {
                if p_values[back_idx] >= p_values[new_idx] {
                    dq.pop_back();
                } else {
                    break;
                }
            }
            dq.push_back(new_idx);

            // The minimum for the current window `[i, i + n - 1]` is at the front of the deque.
            // Add `(minimum_P_value - i * x)` to the total cost.
            total_min_cost += (p_values[*dq.front().unwrap()] - (i as i64) * x_i64) as i128;
        }

        total_min_cost as i64
    }
}