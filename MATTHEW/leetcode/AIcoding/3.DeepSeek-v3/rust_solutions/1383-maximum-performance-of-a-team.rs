use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_performance(n: i32, speed: Vec<i32>, efficiency: Vec<i32>, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut engineers: Vec<(i32, i32)> = efficiency.into_iter().zip(speed.into_iter()).collect();
        engineers.sort_by(|a, b| b.0.cmp(&a.0));

        let mut min_heap = BinaryHeap::new();
        let mut sum_speed = 0i64;
        let mut max_perf = 0i64;

        for (eff, spd) in engineers {
            if min_heap.len() == k {
                sum_speed -= min_heap.pop().unwrap() as i64;
            }
            min_heap.push(Reverse(spd));
            sum_speed += spd as i64;
            let current_perf = sum_speed * eff as i64;
            if current_perf > max_perf {
                max_perf = current_perf;
            }
        }

        (max_perf % 1_000_000_007) as i32
    }
}