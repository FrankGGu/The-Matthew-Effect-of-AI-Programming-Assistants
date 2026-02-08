impl Solution {
    pub fn min_speed_on_time(dist: Vec<i32>, hour_before: f64) -> i32 {
        let n = dist.len();
        if hour_before <= (n - 1) as f64 {
            return -1;
        }

        let mut left = 1;
        let mut right = 10_000_000;
        let mut ans = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut time = 0.0;
            for i in 0..n - 1 {
                time += (dist[i] as f64 / mid as f64).ceil();
            }
            time += dist[n - 1] as f64 / mid as f64;

            if time <= hour_before {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        ans
    }
}