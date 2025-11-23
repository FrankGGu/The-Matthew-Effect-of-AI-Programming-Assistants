impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_performance(n: i32, engineers: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut engineers: Vec<(i32, i32)> = engineers.into_iter().map(|e| (e[0], e[1])).collect();
        engineers.sort_by(|a, b| b.1.cmp(&a.1));

        let mut min_heap = BinaryHeap::new();
        let mut total_sum = 0;
        let mut max_perf = 0;

        for (speed, efficiency) in engineers {
            if min_heap.len() >= k as usize {
                if let Some(&min_speed) = min_heap.peek() {
                    if speed < min_speed {
                        total_sum -= min_speed;
                        min_heap.pop();
                    } else {
                        continue;
                    }
                }
            }
            min_heap.push(speed);
            total_sum += speed;
            max_perf = max_perf.max(total_sum * efficiency);
        }

        max_perf
    }
}
}