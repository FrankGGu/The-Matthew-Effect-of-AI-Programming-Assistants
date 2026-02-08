use std::collections::VecDeque;

impl Solution {
    pub fn maximum_robots(charge_time: Vec<i32>, running_cost: Vec<i32>, budget: i64) -> i32 {
        let n = charge_time.len();
        let mut left = 0;
        let mut current_sum_running_cost: i64 = 0;
        let mut max_len = 0;
        let mut deque: VecDeque<usize> = VecDeque::new(); // Stores indices for chargeTime to find max in window

        for right in 0..n {
            // Add current robot's running cost to the sum
            current_sum_running_cost += running_cost[right] as i64;

            // Maintain the deque for the sliding window maximum of chargeTime
            // Remove elements from the back of the deque that are less than or equal to the current element's chargeTime
            while let Some(&back_idx) = deque.back() {
                if charge_time[back_idx] <= charge_time[right] {
                    deque.pop_back();
                } else {
                    break;
                }
            }
            // Add current element's index to the back of the deque
            deque.push_back(right);

            // While the current window [left, right] is invalid, shrink it from the left
            // The cost condition is max(chargeTime) + sum(runningCost) <= budget
            while let Some(&front_idx) = deque.front() {
                let current_max_charge_time = charge_time[front_idx] as i64;
                let cost = current_max_charge_time + current_sum_running_cost;

                if cost > budget {
                    // Window is invalid, shrink from the left
                    current_sum_running_cost -= running_cost[left] as i64;
                    // If the maximum element in the window is at 'left', remove its index from the front of the deque
                    if front_idx == left {
                        deque.pop_front();
                    }
                    left += 1; // Move the left pointer to shrink the window
                } else {
                    // Window is valid, no need to shrink further for this 'right'
                    break;
                }
            }

            // After potentially shrinking, if the window is valid (left <= right), update max_len
            // If left > right, the window is empty or invalid, and right - left + 1 would be 0 or negative,
            // which won't increase max_len if it's already 0 or positive.
            max_len = max_len.max(right - left + 1);
        }

        max_len as i32
    }
}