use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn total_cost(costs: Vec<i32>, k: i32, candidates: i32) -> i64 {
        let k = k as usize;
        let candidates = candidates as usize;
        let n = costs.len();
        let mut left_heap = BinaryHeap::new();
        let mut right_heap = BinaryHeap::new();
        let mut left_ptr = 0;
        let mut right_ptr = n.saturating_sub(1);

        for _ in 0..candidates {
            if left_ptr <= right_ptr {
                left_heap.push(Reverse(costs[left_ptr]));
                left_ptr += 1;
            }
            if left_ptr <= right_ptr {
                right_heap.push(Reverse(costs[right_ptr]));
                right_ptr -= 1;
            }
        }

        let mut total_cost = 0i64;

        for _ in 0..k {
            let left_min = left_heap.peek().map_or(i32::MAX, |&Reverse(x)| x);
            let right_min = right_heap.peek().map_or(i32::MAX, |&Reverse(x)| x);

            if left_min <= right_min {
                total_cost += left_min as i64;
                left_heap.pop();
                if left_ptr <= right_ptr {
                    left_heap.push(Reverse(costs[left_ptr]));
                    left_ptr += 1;
                }
            } else {
                total_cost += right_min as i64;
                right_heap.pop();
                if left_ptr <= right_ptr {
                    right_heap.push(Reverse(costs[right_ptr]));
                    right_ptr -= 1;
                }
            }
        }

        total_cost
    }
}