impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_cost_to_reach_every_position(cost: Vec<i32>, start_pos: i32) -> Vec<i32> {
        let n = cost.len();
        let mut result = vec![i32::MAX; n];
        let mut queue = VecDeque::new();
        let start_idx = start_pos as usize;
        result[start_idx] = 0;
        queue.push_back(start_idx);

        while let Some(current) = queue.pop_front() {
            for (i, &c) in cost.iter().enumerate() {
                let new_cost = result[current] + c;
                if new_cost < result[i] {
                    result[i] = new_cost;
                    queue.push_back(i);
                }
            }
        }

        result
    }
}
}