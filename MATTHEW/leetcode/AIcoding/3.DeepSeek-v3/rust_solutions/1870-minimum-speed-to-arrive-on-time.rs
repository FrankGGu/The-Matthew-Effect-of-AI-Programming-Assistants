impl Solution {
    pub fn min_speed_on_time(dist: Vec<i32>, hour: f64) -> i32 {
        let n = dist.len();
        if hour <= (n - 1) as f64 {
            return -1;
        }

        let mut left = 1;
        let mut right = *dist.iter().max().unwrap();
        right = right.max((dist[n - 1] as f64 / (hour - (n - 1) as f64)).ceil() as i32;

        let mut result = -1;
        while left <= right {
            let mid = left + (right - left) / 2;
            let total_time = dist.iter().take(n - 1).map(|&d| ((d as f64) / (mid as f64)).ceil() as f64).sum::<f64>() + (dist[n - 1] as f64) / (mid as f64);

            if total_time <= hour {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        result
    }
}