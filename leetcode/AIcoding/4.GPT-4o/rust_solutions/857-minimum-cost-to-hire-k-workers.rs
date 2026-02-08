use std::cmp::Ordering;

pub fn min_cost_to_hire_workers(quality: Vec<i32>, wage: Vec<i32>, k: i32) -> f64 {
    let n = quality.len();
    let mut workers: Vec<(f64, i32)> = (0..n)
        .map(|i| (wage[i] as f64 / quality[i] as f64, quality[i]))
        .collect();
    workers.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap_or(Ordering::Equal));

    let mut total_quality = 0;
    let mut min_cost = f64::INFINITY;
    let mut heap = std::collections::BinaryHeap::new();

    for (rate, q) in workers {
        heap.push(q);
        total_quality += q;
        if heap.len() > k as usize {
            total_quality -= heap.pop().unwrap();
        }
        if heap.len() == k as usize {
            min_cost = min_cost.min(total_quality as f64 * rate);
        }
    }
    min_cost
}