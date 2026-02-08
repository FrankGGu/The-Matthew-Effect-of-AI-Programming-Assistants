impl Solution {
    pub fn ship_within_days(weights: Vec<i32>, days: i32) -> i32 {
        let mut left = *weights.iter().max().unwrap();
        let mut right = weights.iter().sum();

        while left < right {
            let mid = left + (right - left) / 2;
            let mut current_weight = 0;
            let mut days_needed = 1;

            for &weight in &weights {
                if current_weight + weight > mid {
                    days_needed += 1;
                    current_weight = 0;
                }
                current_weight += weight;
            }

            if days_needed <= days {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}