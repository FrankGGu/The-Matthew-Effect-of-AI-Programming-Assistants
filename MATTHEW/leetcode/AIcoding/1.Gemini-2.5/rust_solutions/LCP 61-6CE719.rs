struct Solution;

impl Solution {
    pub fn temperature_trend(temperature_a: Vec<i32>, temperature_b: Vec<i32>) -> i32 {
        let n = temperature_a.len();
        if n <= 1 {
            return 0;
        }

        let mut max_streak = 0;
        let mut current_streak = 0;

        for i in 0..n - 1 {
            let trend_a = (temperature_a[i + 1] - temperature_a[i]).signum();
            let trend_b = (temperature_b[i + 1] - temperature_b[i]).signum();

            if trend_a == trend_b {
                current_streak += 1;
            } else {
                current_streak = 0;
            }
            max_streak = max_streak.max(current_streak);
        }

        max_streak
    }
}