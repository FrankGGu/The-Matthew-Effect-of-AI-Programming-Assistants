impl Solution {

use std::collections::{BinaryHeap, HashMap};

struct Solution {}

impl Solution {
    pub fn time_to_cross(people: Vec<i32>, limit: i32) -> i32 {
        let mut people = people;
        people.sort();
        let mut time = 0;
        let mut left = 0;
        let mut right = people.len() - 1;

        while left <= right {
            if left == right {
                time += people[left];
                break;
            }

            if people[left] + people[left + 1] <= limit {
                time += people[left + 1];
                left += 2;
            } else {
                time += people[right];
                right -= 1;
            }
        }

        time
    }
}
}