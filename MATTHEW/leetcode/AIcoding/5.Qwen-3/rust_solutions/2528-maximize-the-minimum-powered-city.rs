impl Solution {

use std::cmp::min;

struct Solution;

impl Solution {
    pub fn maximize_the_minimum_powered_city(mut cities: Vec<i32>, k: i32) -> i32 {
        let n = cities.len();
        let mut left = 0;
        let mut right = *cities.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left + 1) / 2;
            if Self::can_place_k_power_stations(&mut cities, k, mid) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        left
    }

    fn can_place_k_power_stations(cities: &mut Vec<i32>, k: i32, min_power: i32) -> bool {
        let mut count = 0;
        let mut i = 0;
        let n = cities.len();

        while i < n {
            if cities[i] >= min_power {
                count += 1;
                i += 1;
                while i < n && cities[i] < min_power {
                    i += 1;
                }
            } else {
                i += 1;
            }
        }

        count >= k
    }
}
}