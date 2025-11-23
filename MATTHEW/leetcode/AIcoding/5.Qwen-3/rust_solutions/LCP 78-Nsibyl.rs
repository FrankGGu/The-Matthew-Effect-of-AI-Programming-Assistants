impl Solution {

use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn guard_trains(n: i32, k: i32, trains: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = vec![];
        let mut queue = VecDeque::new();
        let mut index = 0;
        let mut time = 0;

        while index < n as usize {
            if queue.is_empty() {
                time = trains[index][0];
            }

            while index < n as usize && trains[index][0] <= time {
                queue.push_back(trains[index][1]);
                index += 1;
            }

            if queue.len() >= k as usize {
                result.push(time);
                queue.pop_front();
            } else {
                result.push(-1);
            }

            time += 1;
        }

        result
    }
}
}