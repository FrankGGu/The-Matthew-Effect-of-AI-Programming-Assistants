use std::collections::BinaryHeap;

pub fn total_cost(costs: Vec<i32>, k: i32, candidates: i32) -> i64 {
    let mut left = BinaryHeap::new();
    let mut right = BinaryHeap::new();
    let mut n = costs.len();
    let mut total_cost = 0;
    let mut left_index = 0;
    let mut right_index = n as i32 - 1;

    for i in 0..candidates.min(n as i32) {
        left.push(costs[i as usize]);
    }

    for i in 0..candidates.min(n as i32) {
        if right_index >= left_index {
            right.push(costs[right_index as usize]);
            right_index -= 1;
        }
    }

    for _ in 0..k {
        let mut min_cost = i64::MAX;

        if let Some(&cost) = left.peek() {
            min_cost = min_cost.min(cost as i64);
        }
        if let Some(&cost) = right.peek() {
            min_cost = min_cost.min(cost as i64);
        }

        total_cost += min_cost;

        if let Some(cost) = left.pop() {
            if left_index < n as i32 {
                left.push(costs[left_index as usize]);
                left_index += 1;
            }
        } else if let Some(cost) = right.pop() {
            if left_index <= right_index {
                right.push(costs[right_index as usize]);
                right_index -= 1;
            }
        }
    }

    total_cost
}