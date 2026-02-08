struct Solution;

impl Solution {
    pub fn ship_within_days(weights: Vec<i32>, d: i32) -> i32 {
        let mut low = 0;
        let mut high = 0;

        for &weight in &weights {
            low = low.max(weight);
            high += weight;
        }

        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::can_ship(&weights, d, mid) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn can_ship(weights: &[i32], d: i32, capacity: i32) -> bool {
        let mut days_needed = 1;
        let mut current_weight_on_ship = 0;

        for &weight in weights {
            if current_weight_on_ship + weight > capacity {
                days_needed += 1;
                current_weight_on_ship = weight;
            } else {
                current_weight_on_ship += weight;
            }
        }
        days_needed <= d
    }
}