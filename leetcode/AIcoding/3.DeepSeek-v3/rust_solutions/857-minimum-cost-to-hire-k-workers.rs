use std::collections::BinaryHeap;

pub struct Solution;

impl Solution {
    pub fn mincost_to_hire_workers(quality: Vec<i32>, wage: Vec<i32>, k: i32) -> f64 {
        let n = quality.len();
        let k = k as usize;
        let mut workers: Vec<(f64, i32)> = (0..n)
            .map(|i| (wage[i] as f64 / quality[i] as f64, quality[i]))
            .collect();
        workers.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap());

        let mut heap = BinaryHeap::new();
        let mut sum_quality = 0;
        let mut res = std::f64::MAX;

        for worker in workers {
            let (ratio, q) = worker;
            sum_quality += q;
            heap.push(q);

            if heap.len() > k {
                sum_quality -= heap.pop().unwrap();
            }

            if heap.len() == k {
                res = res.min(sum_quality as f64 * ratio);
            }
        }

        res
    }
}