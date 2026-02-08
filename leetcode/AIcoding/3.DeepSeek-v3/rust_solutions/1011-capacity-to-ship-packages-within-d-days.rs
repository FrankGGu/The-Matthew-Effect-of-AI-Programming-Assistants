impl Solution {
    pub fn ship_within_days(weights: Vec<i32>, days: i32) -> i32 {
        let mut left = *weights.iter().max().unwrap();
        let mut right = weights.iter().sum();

        while left < right {
            let mid = left + (right - left) / 2;
            let mut current = 0;
            let mut needed = 1;

            for &w in &weights {
                if current + w > mid {
                    needed += 1;
                    current = 0;
                }
                current += w;
            }

            if needed > days {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}