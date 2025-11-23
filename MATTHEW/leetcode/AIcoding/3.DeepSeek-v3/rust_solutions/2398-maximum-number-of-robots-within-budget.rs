use std::collections::VecDeque;

impl Solution {
    pub fn maximum_robots(charge_times: Vec<i32>, running_costs: Vec<i32>, budget: i64) -> i32 {
        let n = charge_times.len();
        let mut left = 0;
        let mut sum = 0i64;
        let mut deque = VecDeque::new();
        let mut max_len = 0;

        for right in 0..n {
            sum += running_costs[right] as i64;

            while !deque.is_empty() && charge_times[*deque.back().unwrap()] <= charge_times[right] {
                deque.pop_back();
            }
            deque.push_back(right);

            while left <= right && (deque.is_empty() as i64) == 0 && (charge_times[*deque.front().unwrap()] as i64 + (right as i64 - left as i64 + 1) * sum) > budget {
                sum -= running_costs[left] as i64;
                if *deque.front().unwrap() == left {
                    deque.pop_front();
                }
                left += 1;
            }

            if (deque.is_empty() as i64) == 0 {
                let current_len = (right as i32 - left as i32 + 1);
                if current_len > max_len {
                    max_len = current_len;
                }
            }
        }

        max_len
    }
}