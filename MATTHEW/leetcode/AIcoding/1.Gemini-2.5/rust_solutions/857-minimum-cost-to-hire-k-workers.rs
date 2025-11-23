use std::collections::BinaryHeap;

impl Solution {
    pub fn min_cost_to_hire_k_workers(quality: Vec<i32>, wage: Vec<i32>, k: i32) -> f64 {
        let n = quality.len();
        let k = k as usize;

        let mut workers: Vec<(f64, i32)> = Vec::with_capacity(n);
        for i in 0..n {
            workers.push((wage[i] as f64 / quality[i] as f64, quality[i]));
        }

        workers.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap());

        let mut min_cost = f64::MAX;
        let mut current_quality_sum: i32 = 0;
        let mut heap = BinaryHeap::new(); 

        for i in 0..n {
            let (ratio, q) = workers[i];

            heap.push(q);
            current_quality_sum += q;

            if heap.len() > k {
                if let Some(largest_q) = heap.pop() {
                    current_quality_sum -= largest_q;
                }
            }

            if heap.len() == k {
                min_cost = min_cost.min(ratio * current_quality_sum as f64);
            }
        }

        min_cost
    }
}