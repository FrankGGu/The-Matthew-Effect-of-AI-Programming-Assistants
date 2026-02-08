use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn total_cost(costs: Vec<i32>, k: i32, candidates: i32) -> i64 {
        let n = costs.len();
        let k = k as usize;
        let candidates = candidates as usize;

        let mut total_cost: i64 = 0;

        let mut left_ptr = 0;
        let mut right_ptr = n - 1;

        let mut pq_left: BinaryHeap<Reverse<i32>> = BinaryHeap::new();
        let mut pq_right: BinaryHeap<Reverse<i32>> = BinaryHeap::new();

        // Initial filling of priority queues
        // Fill pq_left with 'candidates' elements from the left
        while left_ptr < n && pq_left.len() < candidates {
            pq_left.push(Reverse(costs[left_ptr]));
            left_ptr += 1;
        }

        // Fill pq_right with 'candidates' elements from the right
        // Ensure that right_ptr doesn't overlap with left_ptr if n is small
        while right_ptr >= left_ptr && pq_right.len() < candidates {
            pq_right.push(Reverse(costs[right_ptr]));
            right_ptr -= 1;
        }

        // Hire k workers
        for _ in 0..k {
            let picked_from_left;

            // Determine which priority queue to pick from
            if pq_right.is_empty() {
                // Only pq_left has candidates
                picked_from_left = true;
            } else if pq_left.is_empty() {
                // Only pq_right has candidates
                picked_from_left = false;
            } else {
                // Both PQs have candidates, compare their top elements
                let cost_left = pq_left.peek().unwrap().0;
                let cost_right = pq_right.peek().unwrap().0;

                if cost_left <= cost_right {
                    picked_from_left = true;
                } else {
                    picked_from_left = false;
                }
            }

            // Pop the chosen cost and add to total_cost
            let chosen_cost = if picked_from_left {
                pq_left.pop().unwrap().0
            } else {
                pq_right.pop().unwrap().0
            };
            total_cost += chosen_cost as i64;

            // Replenish the chosen priority queue if there are still workers available
            if left_ptr <= right_ptr {
                if picked_from_left {
                    pq_left.push(Reverse(costs[left_ptr]));
                    left_ptr += 1;
                } else {
                    pq_right.push(Reverse(costs[right_ptr]));
                    right_ptr -= 1;
                }
            }
        }

        total_cost
    }
}