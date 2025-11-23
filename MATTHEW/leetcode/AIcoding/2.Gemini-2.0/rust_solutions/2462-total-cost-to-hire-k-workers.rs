use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn total_cost(costs: Vec<i32>, k: i32, candidates: i32) -> i64 {
        let n = costs.len();
        let candidates = candidates as usize;
        let k = k as usize;
        let mut left_heap: BinaryHeap<Reverse<i32>> = BinaryHeap::new();
        let mut right_heap: BinaryHeap<Reverse<i32>> = BinaryHeap::new();

        for i in 0..std::cmp::min(candidates, n) {
            left_heap.push(Reverse(costs[i]));
        }

        for i in (std::cmp::max(candidates, n) - candidates)..n {
            right_heap.push(Reverse(costs[i]));
        }

        let mut left = candidates;
        let mut right = if candidates > n / 2 { candidates } else { n - candidates };
        let mut total_cost: i64 = 0;

        for _ in 0..k {
            if let (Some(&Reverse(left_min)), Some(&Reverse(right_min))) = (left_heap.peek(), right_heap.peek()) {
                if left_min <= right_min {
                    total_cost += left_heap.pop().unwrap().0 as i64;
                    if left < right {
                        left_heap.push(Reverse(costs[left]));
                        left += 1;
                    }
                } else {
                    total_cost += right_heap.pop().unwrap().0 as i64;
                    if left < right {
                        right -= 1;
                        right_heap.push(Reverse(costs[right]));
                    }
                }
            } else if let Some(&Reverse(left_min)) = left_heap.peek() {
                total_cost += left_heap.pop().unwrap().0 as i64;
            } else if let Some(&Reverse(right_min)) = right_heap.peek() {
                total_cost += right_heap.pop().unwrap().0 as i64;
            }
        }

        total_cost
    }
}