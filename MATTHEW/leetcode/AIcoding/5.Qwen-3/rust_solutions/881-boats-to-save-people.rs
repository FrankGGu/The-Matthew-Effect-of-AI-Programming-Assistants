impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn num_rescue_boats(mut people: Vec<i32>, limit: i32) -> i32 {
        people.sort_unstable();
        let mut boats = 0;
        let (mut left, mut right) = (0, people.len() - 1);

        while left <= right {
            match people[left] + people[right].cmp(&limit) {
                Ordering::Less => left += 1,
                _ => {}
            }
            right -= 1;
            boats += 1;
        }

        boats
    }
}
}