impl Solution {
    pub fn max_run_time(n: i32, batteries: Vec<i32>) -> i64 {
        let total_power: i64 = batteries.iter().map(|&x| x as i64).sum();
        let mut left = 1;
        let mut right = total_power / n as i64;

        while left < right {
            let mid = (left + right + 1) / 2;
            let required_power = mid * n as i64;

            if total_power >= required_power {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        left
    }
}