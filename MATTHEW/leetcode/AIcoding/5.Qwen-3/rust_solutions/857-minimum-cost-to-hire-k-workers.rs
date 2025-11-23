impl Solution {

use std::collections::BinaryHeap;

struct Solution {}

impl Solution {
    pub fn mincost_to_hire_workers(quality: Vec<i32>, wage: Vec<i32>, k: i32) -> f64 {
        let k = k as usize;
        let n = quality.len();
        let mut workers = Vec::with_capacity(n);

        for i in 0..n {
            workers.push((wage[i] as f64 / quality[i] as f64, quality[i]));
        }

        workers.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap());

        let mut max_heap = BinaryHeap::new();
        let mut total_quality = 0;
        let mut min_cost = f64::INFINITY;

        for (ratio, q) in workers {
            max_heap.push(q);
            total_quality += q;

            if max_heap.len() > k {
                total_quality -= max_heap.pop().unwrap();
            }

            if max_heap.len() == k {
                let cost = total_quality as f64 * ratio;
                min_cost = min_cost.min(cost);
            }
        }

        min_cost
    }
}
}