impl Solution {
    pub fn eliminate_maximum(dist: Vec<i32>, speed: Vec<i32>) -> i32 {
        let n = dist.len();
        let mut arrival_times: Vec<f64> = Vec::with_capacity(n);
        for i in 0..n {
            arrival_times.push(dist[i] as f64 / speed[i] as f64);
        }
        arrival_times.sort_by(|a, b| a.partial_cmp(b).unwrap());

        let mut eliminated = 0;
        for i in 0..n {
            if arrival_times[i] > i as f64 {
                eliminated += 1;
            } else {
                break;
            }
        }
        eliminated
    }
}