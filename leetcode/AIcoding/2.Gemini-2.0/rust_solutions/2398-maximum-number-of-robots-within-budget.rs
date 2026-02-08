use std::collections::VecDeque;

impl Solution {
    pub fn maximum_number_of_robots(charge_times: Vec<i32>, running_costs: Vec<i32>, budget: i64) -> i32 {
        let n = charge_times.len();
        let mut left = 0;
        let mut right = 0;
        let mut max_len = 0;
        let mut deque: VecDeque<usize> = VecDeque::new();
        let mut current_sum: i64 = 0;

        while right < n {
            while !deque.is_empty() && charge_times[deque.back().unwrap()] <= charge_times[right] {
                deque.pop_back();
            }
            deque.push_back(right);
            current_sum += running_costs[right] as i64;

            while !deque.is_empty() && (charge_times[deque.front().unwrap()] as i64 + current_sum * (right - left + 1) as i64) > budget {
                current_sum -= running_costs[left] as i64;
                if deque.front().unwrap() == &left {
                    deque.pop_front();
                }
                left += 1;
            }

            max_len = max_len.max(right - left + 1);
            right += 1;
        }

        max_len as i32
    }
}

struct Solution;