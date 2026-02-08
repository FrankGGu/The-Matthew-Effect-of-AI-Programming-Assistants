impl Solution {
    pub fn min_speed_on_time(dist: Vec<i32>, hour: f64) -> i32 {
        let (mut left, mut right) = (1, 1_000_000_000);
        let mut result = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut time = 0.0;

            for i in 0..dist.len() {
                time += (dist[i] as f64 / mid as f64).ceil();
                if i < dist.len() - 1 {
                    time += 1.0;
                }
            }

            if time <= hour {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        result
    }
}