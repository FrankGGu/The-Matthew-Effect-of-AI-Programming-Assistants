impl Solution {
    pub fn max_performance(n: i32, speed: Vec<i32>, efficiency: Vec<i32>, k: i32) -> i32 {
        let mut pairs: Vec<(i32, i32)> = speed.iter().zip(efficiency.iter()).map(|(&s, &e)| (e, s)).collect();
        pairs.sort_by(|a, b| b.0.cmp(&a.0));

        let mut pq = std::collections::BinaryHeap::new();
        let mut total_speed: i64 = 0;
        let mut max_perf: i64 = 0;

        for (e, s) in pairs {
            total_speed += s as i64;
            pq.push(-s);

            if pq.len() as i32 > k {
                if let Some(smallest) = pq.pop() {
                    total_speed += smallest as i64;
                }
            }

            max_perf = std::cmp::max(max_perf, total_speed * (e as i64));
        }

        (max_perf % 1000000007) as i32
    }
}