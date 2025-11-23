use std::collections::BinaryHeap;

pub fn max_performance(n: i32, speed: Vec<i32>, efficiency: Vec<i32>, k: i32) -> i32 {
    let mut engineers: Vec<(i32, i32)> = efficiency.into_iter().zip(speed).collect();
    engineers.sort_by(|a, b| b.0.cmp(&a.0));

    let mut total_speed = 0;
    let mut max_perf = 0;
    let mut min_heap = BinaryHeap::new();

    for (eff, spd) in engineers {
        min_heap.push(spd);
        total_speed += spd;

        if min_heap.len() > k as usize {
            total_speed -= min_heap.pop().unwrap();
        }

        max_perf = max_perf.max(total_speed * eff);
    }

    (max_perf % 1_000_000_007) as i32
}