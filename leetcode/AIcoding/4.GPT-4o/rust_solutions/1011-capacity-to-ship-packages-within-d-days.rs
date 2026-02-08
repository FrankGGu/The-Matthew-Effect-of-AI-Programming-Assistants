impl Solution {
    pub fn ship_within_days(weights: Vec<i32>, days: i32) -> i32 {
        fn can_ship(weights: &Vec<i32>, capacity: i32, days: i32) -> bool {
            let mut total = 0;
            let mut required_days = 1;

            for &weight in weights {
                if total + weight > capacity {
                    total = weight;
                    required_days += 1;
                    if required_days > days {
                        return false;
                    }
                } else {
                    total += weight;
                }
            }
            true
        }

        let (mut left, mut right) = (weights.iter().cloned().max().unwrap(), weights.iter().sum());

        while left < right {
            let mid = left + (right - left) / 2;
            if can_ship(&weights, mid, days) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}