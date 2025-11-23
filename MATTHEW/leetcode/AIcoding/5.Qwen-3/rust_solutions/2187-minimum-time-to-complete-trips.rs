impl Solution {

use std::cmp;

impl Solution {
    pub fn minimum_time(tickets: Vec<i32>, people: i32) -> i32 {
        let (mut left, mut right) = (0, *tickets.iter().min().unwrap() * people);

        while left < right {
            let mid = left + (right - left) / 2;
            let total = tickets.iter().map(|&t| mid / t).sum::<i32>();

            if total >= people {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}

pub struct Solution;
}