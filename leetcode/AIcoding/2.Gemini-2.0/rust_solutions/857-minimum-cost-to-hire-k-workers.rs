use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn mincost_to_hire_workers(quality: Vec<i32>, wage: Vec<i32}, k: i32) -> f64 {
        let n = quality.len();
        let mut workers: Vec<(f64, i32)> = Vec::with_capacity(n);
        for i in 0..n {
            workers.push((wage[i] as f64 / quality[i] as f64, quality[i]));
        }
        workers.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap_or(Ordering::Equal));

        let mut heap: BinaryHeap<i32> = BinaryHeap::new();
        let mut quality_sum: i32 = 0;
        let mut min_cost: f64 = f64::MAX;

        for i in 0..n {
            heap.push(workers[i].1);
            quality_sum += workers[i].1;

            if heap.len() as i32 > k {
                quality_sum -= heap.pop().unwrap();
            }

            if heap.len() as i32 == k {
                min_cost = min_cost.min(workers[i].0 * quality_sum as f64);
            }
        }

        min_cost
    }
}