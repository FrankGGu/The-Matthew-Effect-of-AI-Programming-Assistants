impl Solution {
    pub fn min_days(weights: Vec<i32>, d: i32) -> i32 {
        if weights.len() as i32 < d {
            return -1;
        }

        let mut left = *weights.iter().max().unwrap();
        let mut right = weights.iter().sum();

        while left < right {
            let mid = left + (right - left) / 2;
            let mut days = 1;
            let mut current_weight = 0;

            for &weight in &weights {
                if current_weight + weight <= mid {
                    current_weight += weight;
                } else {
                    days += 1;
                    current_weight = weight;
                }
            }

            if days <= d {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}