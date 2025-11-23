impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn min_time(mut cars: Vec<i32>, mut repair_times: Vec<i32>) -> i64 {
        cars.sort_unstable();
        repair_times.sort_unstable();

        let mut left = 0;
        let mut right = 1_000_000_000;

        while left < right {
            let mid = left + (right - left) / 2;
            if Self::can_repair_all(&cars, &repair_times, mid) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }

    fn can_repair_all(cars: &[i32], repair_times: &[i32], time: i64) -> bool {
        let mut total = 0;
        for &car in cars {
            let mut count = 0;
            for &t in repair_times {
                if t <= time {
                    count += time / t;
                }
            }
            if count < car {
                return false;
            }
        }
        true
    }
}
}