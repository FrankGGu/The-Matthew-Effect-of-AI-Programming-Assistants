impl Solution {

use std::cmp::min;

impl Solution {
    pub fn maximum_candies(mut candies: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut left = 1;
        let mut right = *candies.iter().max().unwrap();

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut count = 0;

            for &c in &candies {
                count += c / mid;
                if count >= k {
                    break;
                }
            }

            if count >= k {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        right
    }
}
}